# flutter-mvvm-template

This is a minimal Flutter MVVM template project.

![GitHub Release](https://img.shields.io/github/v/release/csertant/flutter-mvvm-template)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/csertant/flutter-mvvm-template/release-android.yaml?label=release-android)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)


## Getting Started
1. Create a new git repository from this template.
2. Add the platforms you want to support (iOS, Android, Web, etc.) by running `flutter create . --platforms=android,ios,web` in the project root.

## Developer Commands
- `flutter pub get` - Get dependencies
- `dart run build_runner build --delete-conflicting-outputs` - Generate code (e.g., JSON serialization, Freezed classes)
- `flutter gen-l10n` - Generate localization files
- `flutter analyze` - Analyze the code for potential issues
- `flutter test` - Run unit tests