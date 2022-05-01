part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvSeriesDetailState {}

class TvDetailLoading extends TvSeriesDetailState {}

class TvDetailError extends TvSeriesDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvSeriesDetailState {
  final DetailTvSeries tvDetail;

  const TvDetailHasData(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
