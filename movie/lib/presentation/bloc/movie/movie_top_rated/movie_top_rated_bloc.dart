import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import '../../../../domain/entities/movie.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedBloc(this.getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<MovieTopRatedGetEvent>((event, emit) async {
      emit(MovieTopRatedLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MovieTopRatedError(failure.message));
        },
        (data) {
          emit(MovieTopRatedHasData(data));
        },
      );
    });
  }
}
