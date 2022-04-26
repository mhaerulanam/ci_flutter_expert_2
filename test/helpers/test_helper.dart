import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper_tv_series.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_episode.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart' as tail;

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MovieWatchlistEventFake extends tail.Fake implements MovieWatchlistEvent {}

class MovieWatchlistStateFake extends tail.Fake implements MovieWatchlistState {}

class MockTvSeriesWatchlistBloc
    extends MockBloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState>
    implements TvSeriesWatchlistBloc {}

class TvSeriesWatchlistEventFake extends tail.Fake implements TvSeriesWatchlistEvent {}

class TvSeriesWatchlistStateFake extends tail.Fake implements TvSeriesWatchlistState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MovieRecommendationEventFake extends tail.Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends tail.Fake
    implements MovieRecommendationState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends tail.Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends tail.Fake implements MovieDetailState {}

class MockTvRecommendationBloc
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}

class TvRecommendationEventFake extends tail.Fake
    implements TvSeriesRecommendationEvent {}

class TvRecommendationStateFake extends tail.Fake
    implements TvSeriesRecommendationState {}

class MockTvDetailBloc extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class TvDetailEventFake extends tail.Fake implements TvSeriesDetailEvent {}

class TvDetailStateFake extends tail.Fake implements TvSeriesDetailState {}

class MockTvEpisodeBloc extends MockBloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState>
    implements TvSeriesEpisodeBloc {}

class TvEpisodeEventFake extends tail.Fake implements TvSeriesEpisodeEvent {}

class TvEpisodeStateFake extends tail.Fake implements TvSeriesEpisodeState {}

class MockMoviePopularBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class MoviePopularEventFake extends tail.Fake implements MoviePopularEvent {}

class MoviePopularStateFake extends tail.Fake implements MoviePopularState {}

class MockTvPopularBloc extends MockBloc<TvSeriesPopularEvent, TvSeriesPopularState>
    implements TvSeriesPopularBloc {}

class TvPopularEventFake extends tail.Fake implements TvSeriesPopularEvent {}

class TvPopularStateFake extends tail.Fake implements TvSeriesPopularState {}

class MockMovieTopRatedBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class MovieTopRatedEventFake extends tail.Fake implements MovieTopRatedEvent {}

class MovieTopRatedStateFake extends tail.Fake implements MovieTopRatedState {}

class MockTvTopRatedBloc extends MockBloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState>
    implements TvSeriesTopRatedBloc {}

class TvTopRatedEventFake extends tail.Fake implements TvSeriesTopRatedEvent {}

class TvTopRatedStateFake extends tail.Fake implements TvSeriesTopRatedState {}

class MockTvOnTheAirBloc extends MockBloc<TvOnTheAirEvent, TvOnTheAirState>
    implements TvOnTheAirBloc {}

class TvOnTheAirEventFake extends tail.Fake implements TvOnTheAirEvent {}

class TvOnTheAirStateFake extends tail.Fake implements TvOnTheAirState {}

class MockMovieNowPlayingBloc
    extends MockBloc<MovieNowPlayingEvent, MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class MovieNowPlayingEventFake extends tail.Fake
    implements MovieNowPlayingEvent {}

class MovieNowPlayingStateFake extends tail.Fake
    implements MovieNowPlayingState {}

class MockTvNowPlayingBloc
    extends MockBloc<TvOnTheAirEvent, TvOnTheAirState>
    implements TvOnTheAirBloc {}

class TvNowPlayingEventFake extends tail.Fake implements TvOnTheAirEvent {}

class TvNowPlayingStateFake extends tail.Fake implements TvOnTheAirState {}

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelperTvSeries,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  GetWatchListStatusTvSeries,
  SaveWatchlist,
  SaveWatchlistTvSeries,
  RemoveWatchlist,
  RemoveWatchlistTvSeries,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  SearchMovies,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetTvEpisode,
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetTvOnTheAir,
  SearchTv,
  GetWatchlistMovies,
  GetWatchlistTvSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
