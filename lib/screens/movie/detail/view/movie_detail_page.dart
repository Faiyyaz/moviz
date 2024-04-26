import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviz_repository/moviz_repository.dart';

import '../bloc/moviz_detail_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovizDetailBloc(
        movizRepository: context.read<MovizRepository>(),
      )..add(const MovizDetailSubscriptionRequested()),
      child: const MovizView(),
    );
  }
}

class MovizView extends StatelessWidget {
  const MovizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moviz'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MovizDetailBloc, MovizDetailState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == MovizDetailStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Failure'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<MovizDetailBloc, MovizDetailState>(
          builder: (context, state) {
            if (state.moviz.isEmpty) {
              if (state.status == MovizDetailStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != MovizDetailStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No Movies',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [for (final moviz in state.moviz) Text(moviz.name)],
              ),
            );
          },
        ),
      ),
    );
  }
}
