part of 'tv_detail_bloc.dart';

enum TvDetailStatus { initial, loading, success, failure }

final class TvDetailState extends Equatable {
  const TvDetailState({
    this.status = TvDetailStatus.initial,
    this.moviz = const [],
  });

  final TvDetailStatus status;
  final List<Moviz> moviz;

  TvDetailState copyWith({
    TvDetailStatus Function()? status,
    List<Moviz> Function()? moviz,
  }) {
    return TvDetailState(
      status: status != null ? status() : this.status,
      moviz: moviz != null ? moviz() : this.moviz,
    );
  }

  @override
  List<Object?> get props => [
        status,
        moviz,
      ];
}
