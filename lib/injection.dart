import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper_tv_series.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'data/datasources/tv_series_local_data_source.dart';
import 'domain/usecases/get_popular_tv_series.dart';
import 'domain/usecases/get_tv_episode.dart';
import 'domain/usecases/get_tv_on_the_air.dart';
import 'domain/usecases/get_tv_series_detail.dart';
import 'domain/usecases/get_watchlist_tv_series.dart';
import 'domain/usecases/search_tv.dart';

final locator = GetIt.instance;

void init() {
  //bloc movie
  locator.registerFactory(() => MovieNowPlayingBloc(
        locator(),
      ));
  locator.registerFactory(() => MoviePopularBloc(
        locator(),
      ));
  locator.registerFactory(() => MovieTopRatedBloc(
        locator(),
      ));
  locator.registerFactory(() => MovieDetailBloc(
        getMovieDetail: locator(),
      ));
  locator.registerFactory(() => MovieRecommendationBloc(
        getMovieRecommendations: locator(),
      ));
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => MovieWatchlistBloc(
      getMovieWatchLists: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator()));

  //Bloc Tv Series
  locator.registerFactory(() => TvOnTheAirBloc(
        locator(),
      ));
  locator.registerFactory(() => TvSeriesPopularBloc(
        locator(),
      ));
  locator.registerFactory(() => TvSeriesTopRatedBloc(
        locator(),
      ));
  locator.registerFactory(() => TvSeriesDetailBloc(
        getTvDetail: locator(),
      ));
  locator.registerFactory(() => TvSeriesRecommendationBloc(
        getTvSeriesRecommendations: locator(),
      ));
  locator.registerFactory(
    () => TvSeriesEpisodeBloc(locator()),
  );
  locator.registerFactory(
    () => TvSearchBloc(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(() => TvSeriesWatchlistBloc(
      getWatchListsTvSeries: locator(),
      getWatchListStatusTvSeries: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator()));

  // provider
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getTvOnTheAir: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatusTvSeries: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
      getTvEpisode: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvEpisode(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelperTvSeries: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvSeries>(
      () => DatabaseHelperTvSeries());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
