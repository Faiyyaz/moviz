import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviz_repository/moviz_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.movizRepository,
    super.key,
    required this.router,
  });

  final MovizRepository movizRepository;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: movizRepository,
      child: AppView(router: router),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
