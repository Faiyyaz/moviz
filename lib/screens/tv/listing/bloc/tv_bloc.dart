import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviz_repository/moviz_repository.dart';

part 'tv_event.dart';

part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  TvBloc({
    required MovizRepository movizRepository,
  })  : _movizRepository = movizRepository,
        super(const TvState()) {
    on<TvSubscriptionRequested>(_onSubscriptionRequested);
  }

  final MovizRepository _movizRepository;

  Future<void> _onSubscriptionRequested(
    TvSubscriptionRequested event,
    Emitter<TvState> emit,
  ) async {
    emit(state.copyWith(status: () => TvStatus.loading));

    await emit.forEach<List<Moviz>>(
      _movizRepository.getMoviz(),
      onData: (moviz) => state.copyWith(
        status: () => TvStatus.success,
        moviz: () => moviz,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TvStatus.failure,
      ),
    );
  }
}
