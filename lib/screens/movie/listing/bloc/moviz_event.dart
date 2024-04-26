part of 'moviz_bloc.dart';

sealed class MovizEvent extends Equatable {
  const MovizEvent();

  @override
  List<Object> get props => [];
}

final class MovizSubscriptionRequested extends MovizEvent {
  const MovizSubscriptionRequested();
}
