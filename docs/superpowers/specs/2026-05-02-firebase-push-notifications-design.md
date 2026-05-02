# Firebase Push Notifications — Design

**Date:** 2026-05-02
**Project:** brandface (Flutter)
**Status:** Approved

## Goal

Add Firebase Cloud Messaging (FCM) push notification support to the brandface Flutter app, covering:

- Backend → user notifications (server-sent messages)
- Topic-based broadcasts (subscribe / unsubscribe)
- Deep linking (notification tap opens the app — currently routes to home, structured to be extensible)
- FCM token management (retrieve, persist locally, future backend sync)

## Non-Goals

- No notification list UI / notification history screen
- No domain-layer entities or BLoC for notifications (YAGNI — no UI consumes them yet)
- No backend API integration for token sync (endpoint not ready; `TODO` placeholder added)
- No automated tests for FCM behavior (FCM static API is hard to mock; manual testing instead)
- No specific deep-link routing per notification type yet (single home-route handler, extensible later)

## Architecture

Service + Repository pattern, fitting the existing project structure (clean architecture: `core / data / domain / presentation / utils`).

### New files

| File | Purpose |
|---|---|
| `lib/utils/services/push_notification_service.dart` | FCM init, permission request, topic subscribe/unsubscribe, foreground/background/terminated handlers, local notification rendering, deep-link callback |
| `lib/utils/services/push_notification_background_handler.dart` | Top-level `@pragma('vm:entry-point')` background message handler (FCM requirement: must be a top-level function, kept in its own file for clarity) |
| `lib/data/repositories/notification_token_repository.dart` | Get / persist FCM token via `SharedPreferences`; exposes `sendTokenToBackend()` as a `TODO` stub. **Note:** distinct from existing `NotificationRepositoryImpl` (which handles the in-app notification inbox / mark-as-read flow). |

### Modified files

| File | Change |
|---|---|
| `pubspec.yaml` | Add `firebase_messaging: ^16.0.0` (latest compatible with `firebase_core: ^4.7.0`) |
| `lib/main.dart` | Register background handler before `runApp`; call `sl<PushNotificationService>().init()` after `AppDi().init()` |
| `lib/core/di/app_di.dart` | Manually register `PushNotificationService` and `NotificationTokenRepository` as lazy singletons (matches existing pattern — the project uses manual `GetIt` registration, not generated `injectable` config) |
| `android/app/src/main/AndroidManifest.xml` | Add notification icon meta-data and default channel id |
| `ios/Runner/AppDelegate.swift` | Configure `UNUserNotificationCenter` delegate |

### Dependency injection

Both classes registered manually in `AppDi.init()` using `sl.registerLazySingleton(...)` — matches the existing pattern in `lib/core/di/app_di.dart`. The `injectable` package is in `pubspec.yaml` but not used for generated DI; all wiring is hand-written.

## Data flow

### Initialization sequence (`main.dart`)

```
1. WidgetsFlutterBinding.ensureInitialized()
2. Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
3. FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler)  // top-level
4. AppDi().init()
5. sl<PushNotificationService>().init()
   ├─ requestPermission()  (iOS + Android 13+)
   ├─ create local notification channel (Android)
   ├─ getToken() → NotificationTokenRepository.saveToken(token)
   ├─ NotificationTokenRepository.sendTokenToBackend(token)  // TODO log-only
   ├─ FirebaseMessaging.onMessage.listen(_onForegroundMessage)
   ├─ FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp)
   ├─ FirebaseMessaging.instance.getInitialMessage() → handle if non-null  (terminated launch)
   └─ FirebaseMessaging.instance.onTokenRefresh.listen(_onTokenRefresh)
6. Existing locale / Crashlytics setup
7. runApp(...)
```

### Permission strategy

- **iOS**: `requestPermission(alert: true, badge: true, sound: true)` on first launch (Apple requirement).
- **Android 13+**: `POST_NOTIFICATIONS` runtime permission, requested via the same `requestPermission()` call.
- **Android < 13**: notification permission is auto-granted by the OS; no runtime prompt required.
- **Result**: if user denies, log the outcome and continue. The app must not crash; notifications simply will not arrive.

### Token management

- `getToken()` → `NotificationTokenRepository.saveToken(token)` persists under `SharedPreferences` key `fcm_token`.
- `onTokenRefresh.listen(...)` re-saves on rotation.
- `NotificationTokenRepository.sendTokenToBackend(String token)` — currently a `TODO` log-only method. When the backend endpoint is ready, this becomes a `dio` POST call.

### Notification handling — three lifecycle states

| State | Mechanism | Behavior |
|---|---|---|
| **Foreground** (app open) | `FirebaseMessaging.onMessage.listen(...)` | Show banner via `flutter_local_notifications`; on tap → `_handleNotificationTap(payload)` |
| **Background** (app backgrounded, not killed) | OS shows banner automatically (FCM); `FirebaseMessaging.onMessageOpenedApp.listen(...)` fires on tap | `_handleNotificationTap(message.data)` |
| **Terminated** (app fully killed) | OS shows banner; `FirebaseMessaging.instance.getInitialMessage()` returns the message that launched the app | Called once during `init()`; if non-null → `_handleNotificationTap(message.data)` |

### Background isolate handler

```dart
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Log only — FCM displays the system banner itself for messages with a notification payload.
}
```

### Deep link handler

Single entry point, designed to be extended later:

```dart
void _handleNotificationTap(Map<String, dynamic> data) {
  // Currently: route to home for any notification.
  // Future: switch on data['type'] to route to specific screens.
  AppRouter.router.go('/');
}
```

### Topics API

Service exposes:

```dart
Future<void> subscribeToTopic(String topic);
Future<void> unsubscribeFromTopic(String topic);
```

Topics are not auto-subscribed on init. Callers (e.g. login flow, role/locale changes) invoke these later.

## Foreground UX

- `flutter_local_notifications` (already in `pubspec.yaml`) is initialized with:
  - Android: a single default channel (`brandface_default`, importance high)
  - iOS: standard `DarwinInitializationSettings`
- Foreground messages are rendered via `flutterLocalNotificationsPlugin.show(...)` using `RemoteMessage.notification.title` / `body`.
- On tap, the local notification's `onDidReceiveNotificationResponse` callback decodes the payload and calls `_handleNotificationTap(...)`.

## Error handling

- Every async FCM call is wrapped in `try / catch`; errors are logged (and forwarded to Crashlytics where appropriate, since Crashlytics is already wired in).
- Permission denial is **not** an error — logged and ignored; app continues normally.
- Token retrieval failure → log, do not crash; will retry on next app start or `onTokenRefresh`.

## Platform setup

### Android

- `AndroidManifest.xml` additions inside `<application>`:
  ```xml
  <meta-data
      android:name="com.google.firebase.messaging.default_notification_channel_id"
      android:value="brandface_default" />
  <meta-data
      android:name="com.google.firebase.messaging.default_notification_icon"
      android:resource="@mipmap/ic_launcher" />
  ```
- `google-services.json` already in place (verified).

### iOS — APNs setup (deferred to user)

Code is wired up; APNs key upload is a manual step the user will do later:

1. Apple Developer Portal → Keys → create APNs Auth Key (`.p8`)
2. Firebase Console → Project Settings → Cloud Messaging → upload the `.p8`, paste Key ID and Team ID
3. In Xcode: enable Capabilities → "Push Notifications" and "Background Modes → Remote notifications"

`ios/Runner/AppDelegate.swift` is updated to set `UNUserNotificationCenter.current().delegate = self` so foreground iOS messages are routed correctly.

## Testing plan

- **Manual** — Firebase Console → Cloud Messaging → Send test message:
  1. To an Android device token (foreground)
  2. To the same token with the app backgrounded
  3. To the same token with the app force-killed
  4. After APNs setup: same three flows on iOS
- **Topic test** — call `subscribeToTopic('test')`, send broadcast from console, verify receipt.
- **No automated tests** for FCM — static API mocking has poor ROI. Repository token-save logic (`SharedPreferences`) could get a unit test if desired, but is not in scope here.

## Open items / TODOs left in code

- `NotificationTokenRepository.sendTokenToBackend()` — implement when backend endpoint exists.
- `_handleNotificationTap()` — extend `data['type']` switch when route mapping is decided.
- iOS APNs Auth Key upload (manual user step).
