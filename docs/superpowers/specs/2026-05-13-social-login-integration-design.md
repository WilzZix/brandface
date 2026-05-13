# Social Login Integration — Design

## Goal
Login pagedagi 6 social tugmasini Influerax backenddagi auth endpointlariga ulash. Backend qo'llab-quvvatlamaydigan provayderlar uchun "Tez orada" UI (lokalizatsiya bilan).

## API Surface

| Provider | Endpoint | Request body |
| --- | --- | --- |
| Google | `POST /accounts/v1/auth/social/` | `{provider: "google", id_token, access_token?}` |
| Telegram | `POST /accounts/v1/auth/social/` | `{provider: "telegram", access_token: <raw widget JSON>}` |
| Facebook | `POST /accounts/v1/auth/social/` | `{provider: "facebook", access_token}` |
| LinkedIn | `POST /accounts/v1/auth/linkedin-code/` | `{code, redirect_uri}` |
| Apple | — | UI "Soon" |
| Instagram | — | UI "Soon" |

Muvaffaqiyatli javob `verify-otp` bilan bir xil tuzilishda: `{message, data:{access, refresh, is_new_user, role}}`.

## Architecture

### Domain layer
- `domain/entities/social_auth_entity.dart` — `access`, `refresh`, `isNewUser`, `role`. `VerifyOtpEntity` bilan bir xil shape, lekin alohida turdek saqlanadi.
- `domain/repository/social_auth_repository.dart` — 2 metod: `socialLogin(provider, accessToken, idToken)` va `linkedInCodeExchange(code, redirectUri)`.
- `domain/usecase/login/social_auth_usecase.dart`
- `domain/usecase/login/linkedin_exchange_usecase.dart`

### Data layer
- `data/data_source/network_data_source/social_auth/social_auth_data_source.dart`
- `data/models/social_auth/social_auth_model.dart`
- `data/repositories/social_auth_repository_impl.dart`
- `ApiRoutes`: `socialAuth`, `linkedinCode` qo'shamiz.

### Platform SDK wrappers (`utils/services/social_auth/`)
- `SocialAuthService` (abstract) — barcha provayderlar uchun yagona interfeys: `Future<SocialAuthResult> authenticate(BuildContext ctx)` qaytaradi `{provider, accessToken, idToken?, code?, redirectUri?}`.
- `GoogleAuthService` (`google_sign_in`)
- `FacebookAuthService` (`flutter_facebook_auth`)
- `LinkedInAuthService` — `webview_flutter` orqali OAuth 2.0 authorization code flow; `redirect_uri`'ga tushgan `code` parametrini qaytaradi.
- `TelegramAuthService` — `webview_flutter` orqali Telegram Login Widget; widget callback'idan kelgan JSON'ni `access_token` sifatida qaytaradi.

DI orqali `Map<SocialProvider, SocialAuthService>` ko'rinishida ro'yxatga olinadi.

### Presentation
- `SocialProvider` enum: `google, telegram, facebook, linkedin, apple, instagram` (data layer'da ham, UI'da ham ishlatamiz — yagona manba).
- `LoginEvent.socialLogin({required SocialProvider provider})` — yangi event.
- Yangi `LoginState`'lar:
  - `socialAuthInProgress(SocialProvider provider)`
  - `socialAuthSuccess(SocialAuthEntity)` — `verify-otp` muvaffaqiyat kabi navigatsiya
  - `socialAuthFailure(SocialProvider provider, String msg)`
  - `socialAuthSoon(SocialProvider provider)` — Apple/Instagram uchun
  - `socialAuthCancelled(SocialProvider provider)` — foydalanuvchi SDK oynasini yopib qo'ysa
- LoginBloc:
  - Apple/Instagram → darhol `socialAuthSoon` emit qiladi
  - Boshqalari → `SocialAuthService.authenticate()` chaqiradi → repository orqali backendga jo'natadi → tokenlarni `AuthLocalService`'da saqlaydi → `getMe()` chaqiradi → `profileService`'ga id va role saqlaydi → `socialAuthSuccess` emit qiladi
- `LoginPage` listener:
  - `socialAuthSuccess(entity)` → `isNewUser ? RegistrationPage : (brand ? BrandHomePage : HomePage)`
  - `socialAuthSoon(provider)` → `SoonBottomSheet`
  - `socialAuthFailure` → mavjud failure bottom sheet
  - `socialAuthCancelled` → jim
- `LoginMethods` har bir tugma `LoginEvent.socialLogin(provider: ...)` chaqiradi.

### UI
- `lib/uikit/components/bottom_sheet/soon_bottom_sheet.dart` — yangi widget; ikonka + sarlavha + xabar + OK tugmasi.
- Loyihada `webview_flutter` mavjud emas — `LinkedInAuthPage` va `TelegramAuthPage` Navigator orqali ochiladi va `code`/`raw JSON`'ni `pop` qilib qaytaradi.

### i18n (uz, ru, en) — `login` bloki ichida:
- `soon_title`
- `soon_message` ($provider parametri bilan)
- `social_login_failed`
- `social_login_cancelled`

### Yangi paketlar
- `google_sign_in: ^6.2.2`
- `flutter_facebook_auth: ^7.1.1`
- `webview_flutter: ^4.10.0`

### Sizdan kerak bo'ladi (kod ichida `TODO:` bilan belgilanadi)
- Google: iOS `GIDClientID`, reversed client ID URL scheme; Android — backend `id_token.aud` mos kelishi uchun Web client ID
- Facebook: App ID, Client Token, iOS URL scheme, Android key hashes
- LinkedIn: Client ID, ruxsat etilgan `redirect_uri` (masalan `https://api.influerax.com/api/accounts/v1/auth/linkedin-code/callback`)
- Telegram: bot username (Login Widget uchun) va backend ruxsat etgan `domain`
- iOS `Info.plist` URL schemes
- Android: `google-services.json`, SHA-1, FB key hashes

## Out of scope
- Apple va Instagram SDK integratsiyasi (backend tayyor bo'lguncha)
- iOS/Android native konfiguratsiyani avtomatik yozish — qo'llanma sifatida `TODO:`'lar bilan beriladi
- Test yozish (kichik MVP scope)
