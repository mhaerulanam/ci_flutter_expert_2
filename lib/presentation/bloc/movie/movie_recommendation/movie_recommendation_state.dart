part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  const MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends MovieRecommendationState {
  final List<Movie> movie;

  const MovieRecommendationHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
