import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

import '../../../../domain/entities/movie.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularBloc(this.getPopularMovies) : super(MoviePopularEmpty()) {
    on<MoviePopularEvent>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          emit(MoviePopularHasData(data));
        },
      );
    });
  }
}
