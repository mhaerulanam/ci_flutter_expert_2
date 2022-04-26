import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_episode.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/episode.dart';

part 'tv_series_episode_event.dart';
part 'tv_series_episode_state.dart';

class TvSeriesEpisodeBloc
    extends Bloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState> {
  final GetTvEpisode getTvEpisode;

  TvSeriesEpisodeBloc(this.getTvEpisode) : super(TvEpisodeEmpty()) {
    on<TvSeriesEpisodeGetEvent>((event, emit) async {
      final idTv = event.idTv;
      final idEpisode = event.idEpisode;

      emit(TvEpisodeLoading());
      final result = await getTvEpisode.execute(idTv, idEpisode);

      result.fold(
        (failure) {
          emit(TvEpisodeError(failure.message));
        },
        (data) {
          emit(TvEpisodeHasData(data));
        },
      );
    });
  }
}
