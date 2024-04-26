import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviz_repository/moviz_repository.dart';

import '../bloc/tv_detail_bloc.dart';

class TvDetailPage extends StatelessWidget {
  const TvDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvDetailBloc(
        movizRepository: context.read<MovizRepository>(),
      )..add(const TvDetailSubscriptionRequested()),
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
          BlocListener<TvDetailBloc, TvDetailState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TvDetailStatus.failure) {
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
        child: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state.moviz.isEmpty) {
              if (state.status == TvDetailStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TvDetailStatus.success) {
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
