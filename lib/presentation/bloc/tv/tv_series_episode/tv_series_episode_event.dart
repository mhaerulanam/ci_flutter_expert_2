part of 'tv_series_episode_bloc.dart';

abstract class TvSeriesEpisodeEvent extends Equatable {
  const TvSeriesEpisodeEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesEpisodeGetEvent extends TvSeriesEpisodeEvent {
  final int idTv;
  final int idEpisode;

  const TvSeriesEpisodeGetEvent(this.idTv, this.idEpisode);

  @override
  List<Object> get props => [idTv, idEpisode];
}
