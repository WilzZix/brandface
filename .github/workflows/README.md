# CI/CD (GitHub Actions)

Two workflows:

| Workflow | Trigger | What it does |
|---|---|---|
| `ci.yml` | PRs to `main`, pushes to non-main branches | `flutter pub get` → `analyze` → `test` |
| `android-deploy.yml` | push to `main` | analyze → test → build **signed** `.aab` → upload to Google Play **internal** track |

## Required GitHub secrets

Add these under **Repo → Settings → Secrets and variables → Actions → New repository secret**.
Never commit these values.

| Secret | What it is / how to get it |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | Base64 of the upload keystore. On the machine that has `upload-keystore.jks`: `base64 -i /Users/macbookpro/upload-keystore.jks \| pbcopy` (macOS) and paste. |
| `ANDROID_KEYSTORE_PASSWORD` | `storePassword` from your local `android/key.properties`. |
| `ANDROID_KEY_PASSWORD` | `keyPassword` from your local `android/key.properties`. |
| `ANDROID_KEY_ALIAS` | `keyAlias` from your local `android/key.properties`. |
| `PLAY_SERVICE_ACCOUNT_JSON` | Full JSON of a Google Play service account (see below). Paste the whole file contents. |

## Google Play service account (for `PLAY_SERVICE_ACCOUNT_JSON`)

One-time setup so CI can upload:

1. **Google Cloud Console** → create/select a project → **APIs & Services** → enable **Google Play Android Developer API**.
2. **IAM & Admin → Service Accounts** → create a service account → **Keys → Add key → JSON** → download.
3. **Google Play Console** → **Users & permissions** → **Invite new users** → add the service account email → grant **Release** permissions for the app (at least: *Release to testing tracks*).
4. Paste the downloaded JSON file's contents into the `PLAY_SERVICE_ACCOUNT_JSON` secret.

> The very first upload of a package must be done **manually** in the Play Console (Play needs the app to already exist). After that, CI can push to the internal track.

## Notes

- **versionCode**: `android-deploy.yml` sets it to `100 + <run number>` so each upload is unique and increasing (above the manual 14/15). If you also upload manually, keep those below 100. `versionName` stays as `pubspec.yaml`'s.
- **Flutter version** is pinned to `3.44.0` (matches `.fvmrc`). Bump it in both workflows when you upgrade.
- **Analyze** runs with `--no-fatal-infos --no-fatal-warnings` (only errors fail) because of existing lint debt — tighten later.
