import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies getMovieWatchLists;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistBloc(
      {required this.getMovieWatchLists,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(MovieWatchlistEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await getMovieWatchLists.execute();

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistHasData(data));
        },
      );
    });

    on<GetStatusMovieEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(MovieWatchlistStatusHasData(result));
    });

    on<GetStatusTvEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(MovieWatchlistStatusHasData(result));
    });

    on<AddItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await saveWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });
    on<RemoveItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });
  }
}
