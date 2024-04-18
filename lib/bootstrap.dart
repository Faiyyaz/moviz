import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:moviz/app/app.dart';
import 'package:moviz/app/app_bloc_observer.dart';
import 'package:moviz_api/moviz_api.dart';
import 'package:moviz_repository/moviz_repository.dart';

void bootstrap({required MovizApi movizApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final movizRepository = MovizRepository(movizApi: movizApi);

  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(App(movizRepository: movizRepository));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
