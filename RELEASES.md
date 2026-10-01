# Automated Releases

This project supports automated releases with Fastlane and GitHub Actions.

Workflows:

- release-android.yaml

## Triggering releases

- Push a tag in the form: X.Y.Z
- Example: 1.2.0
- All release workflows also support manual trigger from GitHub Actions.

## Release lanes

- beta
  - Android: uploads to Play internal track as draft.
- production
  - Android: uploads to Play production track.

## Required GitHub secrets

### Android

- ANDROID_KEYSTORE_BASE64
- ANDROID_KEYSTORE_PASSWORD
- ANDROID_KEY_ALIAS
- ANDROID_KEY_PASSWORD
- PLAY_STORE_SERVICE_ACCOUNT_JSON

For manual runs, optionally set `environment_name` to use a different GitHub Environment than `release`.

## Local dry run

Install dependencies:

- bundle install
- flutter pub get

Build and upload Android beta:

- flutter build appbundle --release
- cd android
- bundle exec fastlane beta
