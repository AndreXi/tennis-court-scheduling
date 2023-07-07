import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherModelAdapter());
  // await Hive.deleteBoxFromDisk(SchedulesConst.boxName);

  // Fetch initial data
  try {
    await WeatherRepository(dataProvider: WeatherDataProvider())
        .getData(DateTime.now());
    await SchedulesRepository(dataProvider: SchedulesDataProvider())
        .removePastSchedules();
  } catch (_) {}

  runApp(await builder());
}
