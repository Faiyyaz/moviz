import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviz/router.dart';
import 'package:moviz_repository/moviz_repository.dart';

import '../bloc/tv_bloc.dart';

class TvPage extends StatelessWidget {
  const TvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvBloc(
        movizRepository: context.read<MovizRepository>(),
      )..add(const TvSubscriptionRequested()),
      child: const TvView(),
    );
  }
}

class TvView extends StatelessWidget {
  const TvView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moviz'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TvBloc, TvState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TvStatus.failure) {
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
        child: BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            if (state.moviz.isEmpty) {
              if (state.status == TvStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TvStatus.success) {
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
                children: [
                  for (final moviz in state.moviz)
                    GestureDetector(
                      onTap: () {
                        goRouter.pushNamed('/tvDetails');
                      },
                      child: Text(
                        moviz.name,
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
