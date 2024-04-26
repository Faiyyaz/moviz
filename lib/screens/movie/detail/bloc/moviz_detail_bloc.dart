import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviz_repository/moviz_repository.dart';

part 'moviz_detail_event.dart';

part 'moviz_detail_state.dart';

class MovizDetailBloc extends Bloc<MovizDetailEvent, MovizDetailState> {
  MovizDetailBloc({
    required MovizRepository movizRepository,
  })  : _movizRepository = movizRepository,
        super(const MovizDetailState()) {
    on<MovizDetailSubscriptionRequested>(_onSubscriptionRequested);
  }

  final MovizRepository _movizRepository;

  Future<void> _onSubscriptionRequested(
    MovizDetailSubscriptionRequested event,
    Emitter<MovizDetailState> emit,
  ) async {
    emit(state.copyWith(status: () => MovizDetailStatus.loading));

    await emit.forEach<List<Moviz>>(
      _movizRepository.getMoviz(),
      onData: (moviz) => state.copyWith(
        status: () => MovizDetailStatus.success,
        moviz: () => moviz,
      ),
      onError: (_, __) => state.copyWith(
        status: () => MovizDetailStatus.failure,
      ),
    );
  }
}
