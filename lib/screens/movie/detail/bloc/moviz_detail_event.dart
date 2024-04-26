part of 'moviz_detail_bloc.dart';

sealed class MovizDetailEvent extends Equatable {
  const MovizDetailEvent();

  @override
  List<Object> get props => [];
}

final class MovizDetailSubscriptionRequested extends MovizDetailEvent {
  const MovizDetailSubscriptionRequested();
}
