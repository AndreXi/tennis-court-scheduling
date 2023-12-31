# Tennis Court Scheduling

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Schedule people to use the tennis court.

> Para leer el README en español [Clic aqui](https://github.com/AndreXi/tennis-court-scheduling/blob/main/README-ES.md)

- [Tennis Court Scheduling](#tennis-court-scheduling)
  - [Features ✨](#features-)
  - [Getting Started 🚀](#getting-started-)
  - [Running Tests 🧪](#running-tests-)
  - [Working with Translations 🌐](#working-with-translations-)
    - [Adding Strings](#adding-strings)
    - [Adding Supported Locales](#adding-supported-locales)
    - [Adding Translations](#adding-translations)
    - [Update icons](#update-icons)
    - [Update the Splash Screen](#update-the-splash-screen)
    - [Update the coverage and its badge](#update-the-coverage-and-its-badge)

## Features ✨
- Schedule tennis courts up to 3 people per day
- Shows the schedules from the current day onwards
- Automatically deletes past schedules
- Query the AccuWeather API and store the data in cache
- Shows the probability of rain from the current day to 4 days ahead
- 100% unit test/widget coverage
- English and Spanish locales support

---

## Getting Started 🚀

Install "derry" package to use scripts in the `pubspec.yaml` file.

```sh
dart pub global activate derry
```

or run the commands without the script manager mannualy replacing "derry" for the command.

Then get the dependencies with:

```sh
flutter pub get
```

Remember to set the `.env` file, there is an example `example.env`
you require [create an app in AccuWeather]([http://](https://developer.accuweather.com/accuweather-forecast-api/apis/get/forecasts/v1/daily/5day/%7BlocationKey%7D)) to obtain an apikey.
```env
API_URL=<AccuWeather API URL>
API_KEY_WEATHER=<AccuWeather apikey>
```

And generate the aditional code with `build_runner`

```sh
derry codegen

# or

dart run build_runner build
```

And you are ready run

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

To build is the same as run
```sh
flutter build apk --flavor production --target lib/main_production.dart
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
derry update-coverage
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
derry open-coverage-report
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:tennis_court_scheduling/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

````arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```com.andrexi.tennis_court_scheduling
   com.andrexi.tennis_court_scheduling

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
````

---

### Update icons

You can change app icon configuration for each flavor in the files `flutter_launcher_icons-<flavor>` and then run:

```sh
dart run flutter_launcher_icons
```

---

### Update the Splash Screen

To update the splash screen using [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) run:

```sh
derry update-splash
```

---

### Update the coverage and its badge

Simply run the following command that contains all the steps to do that.

```sh
derry update-coverage
```

---

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
