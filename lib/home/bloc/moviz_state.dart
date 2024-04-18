part of 'moviz_bloc.dart';

enum MovizStatus { initial, loading, success, failure }

final class MovizState extends Equatable {
  const MovizState({
    this.status = MovizStatus.initial,
    this.moviz = const [],
  });

  final MovizStatus status;
  final List<Moviz> moviz;

  MovizState copyWith({
    MovizStatus Function()? status,
    List<Moviz> Function()? moviz,
  }) {
    return MovizState(
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
