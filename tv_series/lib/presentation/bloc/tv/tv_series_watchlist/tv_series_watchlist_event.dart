part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetListEventTv extends TvSeriesWatchlistEvent {}

class GetStatusTvSeriesEvent extends TvSeriesWatchlistEvent {
  final int id;

  const GetStatusTvSeriesEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemTvSeriesEvent extends TvSeriesWatchlistEvent {
  final DetailTvSeries tvSeriesDetail;

  const AddItemTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveItemTvSeriesEvent extends TvSeriesWatchlistEvent {
  final DetailTvSeries tvSeriesDetail;

  const RemoveItemTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [];
}
