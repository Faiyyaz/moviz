part of 'moviz_detail_bloc.dart';

enum MovizDetailStatus { initial, loading, success, failure }

final class MovizDetailState extends Equatable {
  const MovizDetailState({
    this.status = MovizDetailStatus.initial,
    this.moviz = const [],
  });

  final MovizDetailStatus status;
  final List<Moviz> moviz;

  MovizDetailState copyWith({
    MovizDetailStatus Function()? status,
    List<Moviz> Function()? moviz,
  }) {
    return MovizDetailState(
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
