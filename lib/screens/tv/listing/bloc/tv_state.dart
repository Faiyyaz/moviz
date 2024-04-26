part of 'tv_bloc.dart';

enum TvStatus { initial, loading, success, failure }

final class TvState extends Equatable {
  const TvState({
    this.status = TvStatus.initial,
    this.moviz = const [],
  });

  final TvStatus status;
  final List<Moviz> moviz;

  TvState copyWith({
    TvStatus Function()? status,
    List<Moviz> Function()? moviz,
  }) {
    return TvState(
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
