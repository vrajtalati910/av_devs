import 'dart:async';
import 'dart:developer';

import 'package:av_devs/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

Future<void> bootstrap(Widget builder) async {
  Zone.current.fork().runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(builder);

    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
  });
}
