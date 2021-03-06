import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie_detail.dart';
import '../../../../domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail}) : super(MovieDetailEmpty()) {
    on<GetMovieDetailEvent>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(id);

      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (data) {
          emit(MovieDetailHasData(data));
        },
      );
    });
  }
}
