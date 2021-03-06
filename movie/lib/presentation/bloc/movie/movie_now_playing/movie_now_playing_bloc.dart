import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingBloc(this.getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<MovieNowPlayingEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          emit(MovieNowPlayingHasData(data));
        },
      );
    });
  }
}
