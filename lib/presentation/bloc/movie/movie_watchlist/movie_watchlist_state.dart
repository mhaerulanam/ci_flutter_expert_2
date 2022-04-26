part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistSuccess extends MovieWatchlistState {
  final String message;

  const MovieWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;

  const MovieWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistStatusHasData extends MovieWatchlistState {
  final bool result;

  const MovieWatchlistStatusHasData(this.result);

  @override
  List<Object> get props => [result];
}
