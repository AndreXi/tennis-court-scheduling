# Tennis Court Scheduling

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Schedule people to use the tennis court.

- [Tennis Court Scheduling](#tennis-court-scheduling)
  - [Características ✨](#características-)
  - [Antes de comenzar 🚀](#antes-de-comenzar-)
  - [Ejecutando pruebas 🧪](#ejecutando-pruebas-)
  - [Traducciones 🌐](#traducciones-)
    - [Agregando strings](#agregando-strings)
    - [Agregando nuevos locale](#agregando-nuevos-locale)
    - [Agregando Traducciones](#agregando-traducciones)
    - [Actualiza el icono](#actualiza-el-icono)
    - [Actualiza el Splash Screen](#actualiza-el-splash-screen)
    - [Actualizar la cobertura y su badge](#actualizar-la-cobertura-y-su-badge)

## Características ✨
- Agenda canchas de tennis hasta 3 personas por dia
- Muestra los agendamientos desde el dia actual en adelante
- Elimina automaticamente los agendamientos pasados
- Consulta la API de AccuWeather y almacena los datos en cache 
- Muestra la probabilidad de lluvia desde el dia actual hasta los 4 dias en adelante.
- Cobertura de pruebas unitarias / widgets de 100%

---

## Antes de comenzar 🚀

Instala "derry" para usar los script definidos en `pubspec.yaml`.

```sh
dart pub global activate derry
```

O ejecuta los comandos manualmente que están en el `pubspec.yaml`.

Para obtener las dependencias ejecuta:

```sh
flutter pub get
```

Recuerda crear el archivo `.env` hay un ejemplo en `example.env`

Necesitas [crear una app en AccuWeather]([http://](https://developer.accuweather.com/accuweather-forecast-api/apis/get/forecasts/v1/daily/5day/%7BlocationKey%7D)) para obtener una apikey.
```env
API_URL=<AccuWeather API URL>
API_KEY_WEATHER=<AccuWeather apikey>
```

Y genera el codigo adicional con `build_runner`

```sh
derry codegen

# or

dart run build_runner build
```

Ya estás listo para ejecutar el proyecto:

Este proyecto contiene 3 sabores:

- development
- staging
- production

Para ejecutar el sabor deseado, use la configuración de lanzamiento en VSCode/Android Studio o use los siguientes comandos:

```sh
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

De forma parecida es el comando para compilar un apk
```sh
flutter build apk --flavor production --target lib/main_production.dart
```

---

## Ejecutando pruebas 🧪

Para ejecutar todas las pruebas de unidades y widgets, use el siguiente comando:

```sh
derry update-coverage
```

Para ver el informe de cobertura generado, puede usar [lcov](https://github.com/linux-test-project/lcov).

```sh
derry open-coverage-report
```

---

## Traducciones 🌐

Este proyecto se basa en [flutter_localizations][flutter_localizations_link] y sigue la [guía oficial de internacionalización de Flutter][internationalization_link].

### Agregando strings

1. Para agregar un nuevo string localizable, abra el archivo `app_en.arb` en `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Luego agregue una nueva clave/valor y descripción

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

3. Usa el nuevo string

```dart
import 'package:tennis_court_scheduling/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Agregando nuevos locale

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

### Agregando Traducciones

1. Para cada configuración regional admitida, agregue un nuevo archivo ARB en `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Agregue las cadenas traducidas a cada archivo `.arb`:

`app_en.arb`

````arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}

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

### Actualiza el icono

Puede cambiar la configuración del icono de la aplicación para cada sabor en los archivos `flutter_launcher_icons-<sabor>` y luego ejecutar:

```sh
dart run flutter_launcher_icons
```

---

### Actualiza el Splash Screen

Para actualizar la pantalla de inicio usando [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) ejecute:

```sh
derry update-splash
```

---

### Actualizar la cobertura y su badge

Simplemente ejecute el siguiente comando que contiene todos los pasos para hacerlo.
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
