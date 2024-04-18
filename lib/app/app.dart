import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviz_repository/moviz_repository.dart';

import '../home/view/home_page.dart';

class App extends StatelessWidget {
  const App({required this.movizRepository, super.key});

  final MovizRepository movizRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: movizRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
