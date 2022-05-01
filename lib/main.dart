import 'package:common/common/constants.dart';
import 'package:common/common/http_ssl_pinning.dart';
import 'package:common/common/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/movie/search/search_bloc.dart';
import 'package:movie/presentation/pages/about_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/movie_search_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/presentation/bloc/tv/search/tv_search_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:tv_series/presentation/pages/on_the_air_tv_series_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tv_series/presentation/provider/popular_tv_series_notifier.dart';
import 'package:tv_series/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_list_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_search_notifier.dart';
import 'package:tv_series/presentation/provider/watchlist_tv_series_notifier.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesEpisodeBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                  builder: (_) => HomeMoviePage(),
                  settings: settings,
              );
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => PopularMoviesPage(),
                  settings: settings,
              );
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedMoviesPage(),
                  settings: settings,
              );
            case MovieDetailPage.ROUTE_NAME:
              final arg = settings.arguments as MovieDetailArgs;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(args: arg),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final args = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(isMovie: args),
                settings: settings,
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => AboutPage(),
                  settings: settings,
              );
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute
                (builder: (_) => PopularTvSeriesPage(),
                settings: settings,
              );
            case OnTheAirTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => OnTheAirTvSeriesPage(),
                  settings: settings,
              );
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedTvSeriesPage(),
                  settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
