import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviz_repository/moviz_repository.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailBloc({
    required MovizRepository movizRepository,
  })  : _movizRepository = movizRepository,
        super(const TvDetailState()) {
    on<TvDetailSubscriptionRequested>(_onSubscriptionRequested);
  }

  final MovizRepository _movizRepository;

  Future<void> _onSubscriptionRequested(
    TvDetailSubscriptionRequested event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(state.copyWith(status: () => TvDetailStatus.loading));

    await emit.forEach<List<Moviz>>(
      _movizRepository.getMoviz(),
      onData: (moviz) => state.copyWith(
        status: () => TvDetailStatus.success,
        moviz: () => moviz,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TvDetailStatus.failure,
      ),
    );
  }
}
