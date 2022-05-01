part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistSuccess extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistHasData extends TvSeriesWatchlistState {
  final List<TvSeries> result;

  const TvSeriesWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvSeriesWatchlistStatusHasData extends TvSeriesWatchlistState {
  final bool result;

  const TvSeriesWatchlistStatusHasData(this.result);

  @override
  List<Object> get props => [result];
}
