import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviz/router.dart';
import 'package:moviz_repository/moviz_repository.dart';

import '../bloc/moviz_bloc.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovizBloc(
        movizRepository: context.read<MovizRepository>(),
      )..add(const MovizSubscriptionRequested()),
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
          BlocListener<MovizBloc, MovizState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == MovizStatus.failure) {
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
        child: BlocBuilder<MovizBloc, MovizState>(
          builder: (context, state) {
            if (state.moviz.isEmpty) {
              if (state.status == MovizStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != MovizStatus.success) {
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
                        goRouter.pushNamed('/movieDetails');
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
