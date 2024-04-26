part of 'tv_bloc.dart';

sealed class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

final class TvSubscriptionRequested extends TvEvent {
  const TvSubscriptionRequested();
}
