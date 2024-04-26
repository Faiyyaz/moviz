import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:moviz/app/app.dart';
import 'package:moviz/app/app_bloc_observer.dart';
import 'package:moviz/router.dart';
import 'package:moviz_api/moviz_api.dart';
import 'package:moviz_repository/moviz_repository.dart';

void bootstrap({required MovizApi movizApi}) {
  runZonedGuarded(() async {
    final movizRepository = MovizRepository(movizApi: movizApi);
    final GoRouter router = goRouter;

    WidgetsFlutterBinding.ensureInitialized();
    runApp(
      App(
        movizRepository: movizRepository,
        router: router,
      ),
    );

    Bloc.observer = const AppBlocObserver();

    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
  }, (error, stack) {
    debugPrint(error.toString());
  });
}
