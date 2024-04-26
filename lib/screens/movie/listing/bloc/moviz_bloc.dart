import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviz_repository/moviz_repository.dart';

part 'moviz_event.dart';

part 'moviz_state.dart';

class MovizBloc extends Bloc<MovizEvent, MovizState> {
  MovizBloc({
    required MovizRepository movizRepository,
  })  : _movizRepository = movizRepository,
        super(const MovizState()) {
    on<MovizSubscriptionRequested>(_onSubscriptionRequested);
  }

  final MovizRepository _movizRepository;

  Future<void> _onSubscriptionRequested(
    MovizSubscriptionRequested event,
    Emitter<MovizState> emit,
  ) async {
    emit(state.copyWith(status: () => MovizStatus.loading));

    await emit.forEach<List<Moviz>>(
      _movizRepository.getMoviz(),
      onData: (moviz) => state.copyWith(
        status: () => MovizStatus.success,
        moviz: () => moviz,
      ),
      onError: (_, __) => state.copyWith(
        status: () => MovizStatus.failure,
      ),
    );
  }
}
