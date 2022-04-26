part of 'tv_series_episode_bloc.dart';

abstract class TvSeriesEpisodeState extends Equatable {
  const TvSeriesEpisodeState();

  @override
  List<Object> get props => [];
}

class TvEpisodeEmpty extends TvSeriesEpisodeState {}

class TvEpisodeLoading extends TvSeriesEpisodeState {}

class TvEpisodeError extends TvSeriesEpisodeState {
  final String message;

  const TvEpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

class TvEpisodeHasData extends TvSeriesEpisodeState {
  final List<Episode> result;

  const TvEpisodeHasData(this.result);

  @override
  List<Object> get props => [result];
}
