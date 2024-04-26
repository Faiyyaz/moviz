part of 'tv_detail_bloc.dart';

sealed class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

final class TvDetailSubscriptionRequested extends TvDetailEvent {
  const TvDetailSubscriptionRequested();
}
