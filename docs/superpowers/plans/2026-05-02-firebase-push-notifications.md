# Firebase Push Notifications Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Firebase Cloud Messaging (FCM) to the brandface Flutter app — token retrieval/persistence, topic subscribe/unsubscribe, foreground/background/terminated message handling with deep-link callback (currently routes to home).

**Architecture:** Service + Repository pattern. `PushNotificationService` (in `lib/utils/services/`) wraps `firebase_messaging` and `flutter_local_notifications`. `NotificationTokenRepository` (in `lib/data/repositories/`) handles token persistence to `SharedPreferences` and exposes a `TODO` stub for future backend sync. Background handler is a top-level `@pragma('vm:entry-point')` function in its own file. Both classes registered manually in `AppDi.init()`.

**Tech Stack:** Flutter 3.11+, `firebase_messaging` (new), `firebase_core` 4.x (existing), `flutter_local_notifications` 21.x (existing), `shared_preferences` 2.x (existing), `get_it` 9.x (existing), `go_router` 17.x (existing).

**Spec:** [docs/superpowers/specs/2026-05-02-firebase-push-notifications-design.md](../specs/2026-05-02-firebase-push-notifications-design.md)

---

## File map

**Create:**
- `lib/utils/services/push_notification_background_handler.dart` — top-level FCM background handler
- `lib/utils/services/push_notification_service.dart` — FCM init, permission, topics, foreground/background/terminated handlers, local notification rendering
- `lib/data/repositories/notification_token_repository.dart` — FCM token persistence + backend-sync TODO stub

**Modify:**
- `pubspec.yaml` — add `firebase_messaging` dependency
- `android/app/src/main/AndroidManifest.xml` — add default notification channel and icon meta-data
- `ios/Runner/AppDelegate.swift` — set `UNUserNotificationCenter.current().delegate = self`
- `lib/core/di/app_di.dart` — register `NotificationTokenRepository` and `PushNotificationService`
- `lib/main.dart` — register background handler before `runApp`; call `sl<PushNotificationService>().init()` after `AppDi().init()`

---

## Task 1: Add `firebase_messaging` dependency

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Add dependency**

In `pubspec.yaml`, in the `dependencies:` section right after `firebase_analytics: ^12.3.0`, add:

```yaml
  firebase_messaging: ^16.0.0
```

The full block around it should look like:

```yaml
  firebase_core: ^4.7.0
  firebase_crashlytics: ^5.2.0
  firebase_analytics: ^12.3.0
  firebase_messaging: ^16.0.0
  flutter_local_notifications: ^21.0.0
```

- [ ] **Step 2: Fetch packages**

Run: `cd /Users/macbookpro/StudioProjects/brandface && flutter pub get`

Expected: succeeds, `firebase_messaging` appears in `pubspec.lock`. If version `^16.0.0` is incompatible with `firebase_core: ^4.7.0`, the resolver will report — in that case, run `flutter pub upgrade firebase_messaging` and accept the resolved version (must be the latest that resolves with `firebase_core 4.x`).

- [ ] **Step 3: Verify import resolves**

Run: `dart analyze lib/main.dart`

Expected: no errors. (We have not used the import yet; this just confirms the package downloaded cleanly.)

- [ ] **Step 4: Commit**

```bash
git add pubspec.yaml pubspec.lock
git commit -m "feat(deps): add firebase_messaging for push notifications"
```

---

## Task 2: Create the background message handler

FCM requires the background handler to be a top-level (non-anonymous) function annotated with `@pragma('vm:entry-point')`. Putting it in its own file keeps the service file focused.

**Files:**
- Create: `lib/utils/services/push_notification_background_handler.dart`

- [ ] **Step 1: Create the file**

Create `lib/utils/services/push_notification_background_handler.dart` with:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    debugPrint('[FCM][bg] message received: id=${message.messageId} '
        'data=${message.data}');
  }
  // FCM displays the system banner itself for messages with a notification
  // payload. No further action required here.
}
```

- [ ] **Step 2: Verify it compiles**

Run: `dart analyze lib/utils/services/push_notification_background_handler.dart`

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add lib/utils/services/push_notification_background_handler.dart
git commit -m "feat(notifications): add FCM background message handler"
```

---

## Task 3: Create `NotificationTokenRepository`

This repository owns the FCM token: retrieving the cached value, persisting on update, and the backend-sync stub.

**Files:**
- Create: `lib/data/repositories/notification_token_repository.dart`

- [ ] **Step 1: Create the file**

Create `lib/data/repositories/notification_token_repository.dart` with:

```dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationTokenRepository {
  static const String _kFcmTokenKey = 'fcm_token';

  final SharedPreferences _prefs;

  const NotificationTokenRepository({required SharedPreferences prefs})
      : _prefs = prefs;

  String? getCachedToken() => _prefs.getString(_kFcmTokenKey);

  Future<void> saveToken(String token) async {
    await _prefs.setString(_kFcmTokenKey, token);
    if (kDebugMode) {
      debugPrint('[FCM] token saved locally: ${_preview(token)}');
    }
  }

  Future<void> clearToken() async {
    await _prefs.remove(_kFcmTokenKey);
  }

  // TODO(backend): wire this to the backend endpoint once available
  // (e.g. POST /api/users/fcm-token via DioClient). For now, log only so
  // that the call site can already invoke it without behavioral change.
  Future<void> sendTokenToBackend(String token) async {
    if (kDebugMode) {
      debugPrint('[FCM] sendTokenToBackend (stub): ${_preview(token)}');
    }
  }

  String _preview(String token) =>
      token.length <= 12 ? token : '${token.substring(0, 12)}...';
}
```

- [ ] **Step 2: Verify it compiles**

Run: `dart analyze lib/data/repositories/notification_token_repository.dart`

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add lib/data/repositories/notification_token_repository.dart
git commit -m "feat(notifications): add NotificationTokenRepository for FCM token persistence"
```

---

## Task 4: Create `PushNotificationService` skeleton with init + permission

We build the service incrementally over Tasks 4–7 to keep each commit reviewable. This task adds the class with `init()`, permission request, and token retrieval — no message handlers yet.

**Files:**
- Create: `lib/utils/services/push_notification_service.dart`

- [ ] **Step 1: Create the file**

Create `lib/utils/services/push_notification_service.dart` with:

```dart
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/repositories/notification_token_repository.dart';

class PushNotificationService {
  static const String androidChannelId = 'brandface_default';
  static const String androidChannelName = 'Brandface notifications';
  static const String androidChannelDescription =
      'Default channel for brandface push notifications';

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final NotificationTokenRepository _tokenRepository;

  StreamSubscription<String>? _tokenRefreshSub;

  PushNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required NotificationTokenRepository tokenRepository,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _tokenRepository = tokenRepository;

  Future<void> init() async {
    await _requestPermission();
    await _retrieveAndStoreToken();
    _listenForTokenRefresh();
  }

  Future<void> _requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (kDebugMode) {
        debugPrint('[FCM] permission status: ${settings.authorizationStatus}');
      }
    } catch (e, st) {
      debugPrint('[FCM] requestPermission failed: $e\n$st');
    }
  }

  Future<void> _retrieveAndStoreToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) {
        debugPrint('[FCM] getToken returned null');
        return;
      }
      await _tokenRepository.saveToken(token);
      await _tokenRepository.sendTokenToBackend(token);
    } catch (e, st) {
      debugPrint('[FCM] getToken failed: $e\n$st');
    }
  }

  void _listenForTokenRefresh() {
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub = _messaging.onTokenRefresh.listen(
      (token) async {
        await _tokenRepository.saveToken(token);
        await _tokenRepository.sendTokenToBackend(token);
      },
      onError: (Object e, StackTrace st) {
        debugPrint('[FCM] onTokenRefresh error: $e\n$st');
      },
    );
  }

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
  }
}
```

- [ ] **Step 2: Verify it compiles**

Run: `dart analyze lib/utils/services/push_notification_service.dart`

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add lib/utils/services/push_notification_service.dart
git commit -m "feat(notifications): add PushNotificationService skeleton with permission + token"
```

---

## Task 5: Add local notification setup to the service

Initialize `flutter_local_notifications` (Android channel + iOS settings) so we can render foreground messages in Task 6.

**Files:**
- Modify: `lib/utils/services/push_notification_service.dart`

- [ ] **Step 1: Add `_initLocalNotifications()` method and call it from `init()`**

Replace the existing `init()` method body in `lib/utils/services/push_notification_service.dart` so that the full method becomes:

```dart
Future<void> init() async {
  await _initLocalNotifications();
  await _requestPermission();
  await _retrieveAndStoreToken();
  _listenForTokenRefresh();
}
```

Then add this new method to the class (place it right after `init()`):

```dart
Future<void> _initLocalNotifications() async {
  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await _localNotifications.initialize(initSettings);

  const androidChannel = AndroidNotificationChannel(
    androidChannelId,
    androidChannelName,
    description: androidChannelDescription,
    importance: Importance.high,
  );

  await _localNotifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);
}
```

Notes:
- iOS permission flags here are `false` because we ask via `firebase_messaging.requestPermission()` which covers both stacks.
- The `@mipmap/ic_launcher` asset already exists in this project (verified — it's the launcher icon).

- [ ] **Step 2: Verify it compiles**

Run: `dart analyze lib/utils/services/push_notification_service.dart`

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add lib/utils/services/push_notification_service.dart
git commit -m "feat(notifications): initialize flutter_local_notifications + Android channel"
```

---

## Task 6: Add foreground / background-tap / terminated-launch handlers

Wire up the three FCM lifecycle paths and the local-notification banner used in foreground.

**Files:**
- Modify: `lib/utils/services/push_notification_service.dart`

- [ ] **Step 1: Add deep-link callback wiring**

At the top of `PushNotificationService` (right after the constructor declaration `_tokenRepository = tokenRepository;` and before `StreamSubscription<String>? _tokenRefreshSub;`), add an optional callback property:

```dart
  /// Invoked when the user taps a notification (foreground banner, background
  /// tap, or terminated-state launch). Set this from the caller (e.g. main.dart)
  /// to route via go_router.
  void Function(Map<String, dynamic> data)? onNotificationTap;
```

So the relevant section reads:

```dart
  PushNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required NotificationTokenRepository tokenRepository,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _tokenRepository = tokenRepository;

  /// Invoked when the user taps a notification (foreground banner, background
  /// tap, or terminated-state launch). Set this from the caller (e.g. main.dart)
  /// to route via go_router.
  void Function(Map<String, dynamic> data)? onNotificationTap;

  StreamSubscription<String>? _tokenRefreshSub;
```

- [ ] **Step 2: Update `init()` to register handlers**

Replace the `init()` method body so the full method becomes:

```dart
Future<void> init() async {
  await _initLocalNotifications();
  await _requestPermission();
  await _retrieveAndStoreToken();
  _listenForTokenRefresh();

  FirebaseMessaging.onMessage.listen(_onForegroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

  final initial = await _messaging.getInitialMessage();
  if (initial != null) {
    _dispatchTap(initial.data);
  }
}
```

- [ ] **Step 3: Update `_initLocalNotifications()` to handle banner taps**

Replace the existing `_localNotifications.initialize(initSettings);` line with:

```dart
  await _localNotifications.initialize(
    initSettings,
    onDidReceiveNotificationResponse: _onLocalNotificationTap,
  );
```

- [ ] **Step 4: Add the message handler methods**

Add these methods to the class (place them right after `_listenForTokenRefresh()`):

```dart
Future<void> _onForegroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    debugPrint('[FCM][fg] id=${message.messageId} data=${message.data}');
  }

  final notification = message.notification;
  if (notification == null) return;

  await _localNotifications.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        androidChannelId,
        androidChannelName,
        channelDescription: androidChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(),
    ),
    payload: _encodePayload(message.data),
  );
}

void _onMessageOpenedApp(RemoteMessage message) {
  if (kDebugMode) {
    debugPrint('[FCM][open] id=${message.messageId} data=${message.data}');
  }
  _dispatchTap(message.data);
}

void _onLocalNotificationTap(NotificationResponse response) {
  final raw = response.payload;
  if (raw == null || raw.isEmpty) {
    _dispatchTap(const {});
    return;
  }
  _dispatchTap(_decodePayload(raw));
}

void _dispatchTap(Map<String, dynamic> data) {
  final cb = onNotificationTap;
  if (cb == null) {
    debugPrint('[FCM] onNotificationTap not set; dropping tap. data=$data');
    return;
  }
  cb(data);
}

String _encodePayload(Map<String, dynamic> data) {
  if (data.isEmpty) return '';
  return jsonEncode(data);
}

Map<String, dynamic> _decodePayload(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    return {};
  } catch (_) {
    return {};
  }
}
```

- [ ] **Step 5: Add the missing import**

At the top of `lib/utils/services/push_notification_service.dart`, add:

```dart
import 'dart:convert';
```

(Place it as the first import, before `dart:async`.)

- [ ] **Step 6: Verify it compiles**

Run: `dart analyze lib/utils/services/push_notification_service.dart`

Expected: no errors. If `Importance` / `Priority` cause a name conflict warning, ignore — these are from `flutter_local_notifications`.

- [ ] **Step 7: Commit**

```bash
git add lib/utils/services/push_notification_service.dart
git commit -m "feat(notifications): handle foreground, background-tap, and terminated-launch messages"
```

---

## Task 7: Add topic subscribe/unsubscribe API

Public helpers callers can use later (e.g. on login or locale change).

**Files:**
- Modify: `lib/utils/services/push_notification_service.dart`

- [ ] **Step 1: Add the methods**

In `lib/utils/services/push_notification_service.dart`, add these methods to the class (place them right after `init()`):

```dart
Future<void> subscribeToTopic(String topic) async {
  try {
    await _messaging.subscribeToTopic(topic);
    if (kDebugMode) debugPrint('[FCM] subscribed to topic: $topic');
  } catch (e, st) {
    debugPrint('[FCM] subscribeToTopic($topic) failed: $e\n$st');
  }
}

Future<void> unsubscribeFromTopic(String topic) async {
  try {
    await _messaging.unsubscribeFromTopic(topic);
    if (kDebugMode) debugPrint('[FCM] unsubscribed from topic: $topic');
  } catch (e, st) {
    debugPrint('[FCM] unsubscribeFromTopic($topic) failed: $e\n$st');
  }
}
```

- [ ] **Step 2: Verify it compiles**

Run: `dart analyze lib/utils/services/push_notification_service.dart`

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add lib/utils/services/push_notification_service.dart
git commit -m "feat(notifications): add topic subscribe/unsubscribe API"
```

---

## Task 8: Register both classes in DI

**Files:**
- Modify: `lib/core/di/app_di.dart`

- [ ] **Step 1: Add imports**

At the top of `lib/core/di/app_di.dart`, add (alphabetical order, near the other `data/repositories` imports):

```dart
import 'package:brandface/data/repositories/notification_token_repository.dart';
```

And near the other `utils/services` imports at the bottom of the import block:

```dart
import '../../utils/services/push_notification_service.dart';
```

And in the third-party section:

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
```

- [ ] **Step 2: Register the new dependencies**

In `lib/core/di/app_di.dart`, inside `AppDi.init()`, after the existing line `sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);`, add:

```dart
    // Push notifications
    sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
    sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => FlutterLocalNotificationsPlugin(),
    );
    sl.registerLazySingleton<NotificationTokenRepository>(
      () => NotificationTokenRepository(prefs: sl()),
    );
    sl.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService(
        messaging: sl(),
        localNotifications: sl(),
        tokenRepository: sl(),
      ),
    );
```

So the early section of `init()` becomes:

```dart
Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Push notifications
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
  sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );
  sl.registerLazySingleton<NotificationTokenRepository>(
    () => NotificationTokenRepository(prefs: sl()),
  );
  sl.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(
      messaging: sl(),
      localNotifications: sl(),
      tokenRepository: sl(),
    ),
  );

  sl.registerLazySingleton<IAuthLocalService>(() => AuthLocalService(sl()));
  // ... rest unchanged
```

- [ ] **Step 3: Verify it compiles**

Run: `dart analyze lib/core/di/app_di.dart`

Expected: no errors.

- [ ] **Step 4: Commit**

```bash
git add lib/core/di/app_di.dart
git commit -m "feat(di): register PushNotificationService and NotificationTokenRepository"
```

---

## Task 9: Wire it all up in `main.dart`

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Add imports**

At the top of `lib/main.dart`, add (with the other Firebase imports):

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
```

And next to the existing `core/di/app_di.dart` import, add:

```dart
import 'utils/services/push_notification_background_handler.dart';
import 'utils/services/push_notification_service.dart';
```

- [ ] **Step 2: Update `main()` to register the background handler and start the service**

Replace the existing `main()` function in `lib/main.dart` with:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await AppDi().init();

  final pushService = sl<PushNotificationService>();
  pushService.onNotificationTap = (data) {
    // Currently route to home for any notification.
    // Future: switch on data['type'] to route to specific screens.
    AppRouter.router.go('/');
  };
  await pushService.init();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  final savedLocale = await AppLanguageService(prefs: sl()).getAppLocale();
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  LocaleSettings.setLocale(savedLocale);
  runApp(TranslationProvider(child: const MyApp()));
}
```

Notes:
- `onBackgroundMessage` MUST be registered before `runApp` (FCM requirement).
- `pushService.init()` is awaited so the initial-message check completes before the UI builds — otherwise a terminated-launch tap could race the router.
- The existing Crashlytics / locale lines are kept in their original order; only the push-service block is inserted.

- [ ] **Step 3: Verify the file compiles**

Run: `dart analyze lib/main.dart`

Expected: no errors.

- [ ] **Step 4: Commit**

```bash
git add lib/main.dart
git commit -m "feat(notifications): initialize FCM and wire deep-link callback in main"
```

---

## Task 10: Android — add notification meta-data

Tells FCM which channel + icon to use for notification-payload messages handled directly by the system.

**Files:**
- Modify: `android/app/src/main/AndroidManifest.xml`

- [ ] **Step 1: Add meta-data inside `<application>`**

In `android/app/src/main/AndroidManifest.xml`, inside the `<application>` element, after the existing `<meta-data android:name="flutterEmbedding" .../>` element, add:

```xml
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="brandface_default" />
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_icon"
            android:resource="@mipmap/ic_launcher" />
```

The full section should now read:

```xml
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="brandface_default" />
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_icon"
            android:resource="@mipmap/ic_launcher" />
    </application>
```

- [ ] **Step 2: Verify XML is valid**

Run: `xmllint --noout android/app/src/main/AndroidManifest.xml`

Expected: no output (means valid XML). If `xmllint` is not installed, run a quick build instead: `cd android && ./gradlew :app:processDebugManifest && cd ..` — should succeed.

- [ ] **Step 3: Commit**

```bash
git add android/app/src/main/AndroidManifest.xml
git commit -m "feat(android): set FCM default notification channel and icon"
```

---

## Task 11: iOS — set `UNUserNotificationCenter` delegate

So foreground iOS notification taps and presentation are routed through Flutter's plugin layer.

**Files:**
- Modify: `ios/Runner/AppDelegate.swift`

- [ ] **Step 1: Update `AppDelegate.swift`**

Replace the contents of `ios/Runner/AppDelegate.swift` with:

```swift
import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
```

Notes:
- `FlutterAppDelegate` conforms to `UNUserNotificationCenterDelegate` in recent Flutter versions, so direct assignment compiles. If the build fails with a protocol conformance error, the project's Flutter version is older than expected — in that case, declare conformance via `extension AppDelegate: UNUserNotificationCenterDelegate {}` and re-run.
- The `import UserNotifications` line is the only new import.

- [ ] **Step 2: Verify the iOS project still builds**

Run: `cd /Users/macbookpro/StudioProjects/brandface && flutter build ios --no-codesign --debug`

Expected: build succeeds. (If you do not have an iOS toolchain locally, skip this verification — but flag it in the commit message and note that an iOS build run is required before merging.)

- [ ] **Step 3: Commit**

```bash
git add ios/Runner/AppDelegate.swift
git commit -m "feat(ios): attach UNUserNotificationCenter delegate for FCM"
```

---

## Task 12: Manual end-to-end verification

No automated tests for FCM (per spec — static API, low ROI). Verify on a device.

- [ ] **Step 1: Build & run on Android device**

Run: `cd /Users/macbookpro/StudioProjects/brandface && flutter run -d <android-device-id>`

(If no device list known, run `flutter devices` first.)

Expected: app launches without crash. In the debug console look for `[FCM] permission status: ...` and `[FCM] token saved locally: <preview>...`.

- [ ] **Step 2: Capture the FCM token**

In the debug console find the line `[FCM] token saved locally: <12-char-prefix>...` — this is just a preview. To get the full token for testing, temporarily add `debugPrint('[FCM] FULL token: $token');` inside `_retrieveAndStoreToken` AFTER the null check, run again, copy the token, then revert that change before committing anything else.

- [ ] **Step 3: Send a foreground test message**

In Firebase Console → Cloud Messaging → New campaign → Notifications → "Send test message" → paste the FCM token → "Test".

With the app open in foreground, confirm a banner appears (this is the local notification we render). Tap it — confirm the app navigates to home (`/`).

- [ ] **Step 4: Send a background test message**

Background the app (don't kill it). Send another test message from the console. Confirm the system banner appears. Tap it — confirm the app re-opens at home.

- [ ] **Step 5: Send a terminated-launch test message**

Force-kill the app. Send another test message. Confirm the system banner appears. Tap it — confirm the app cold-launches and lands on home.

- [ ] **Step 6: Topic test (optional)**

In Dart code (e.g. a temporary button on a debug screen, or a one-shot call from `main`) call `sl<PushNotificationService>().subscribeToTopic('test_brandface')`. Then in the console send a topic message to `test_brandface` and confirm receipt. Unsubscribe afterward.

- [ ] **Step 7: iOS verification (after APNs Auth Key is uploaded)**

Skip until the user uploads the APNs `.p8` to Firebase Console. Then repeat steps 1–5 on an iOS device. (No commit needed — verification only.)

- [ ] **Step 8: No commit unless verification turned up code changes**

If steps 1–6 surfaced code changes (e.g. a missing icon, a permission issue), fix them in a follow-up commit referencing the task number. Otherwise this task ends without a commit.
