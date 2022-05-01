import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart' as tail;
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:watchlist/presentation/movie/movie_watchlist/movie_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';


void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;
  late MockTvSeriesWatchlistBloc mockTvSeriesWatchlistBloc;
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationBloc mockTvRecommendationBloc;
  late MockTvEpisodeBloc mockTvEpisodeBloc;

  setUp(() {
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    mockTvSeriesWatchlistBloc = MockTvSeriesWatchlistBloc();
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationBloc = MockTvRecommendationBloc();
    mockTvEpisodeBloc = MockTvEpisodeBloc();
  });

  group("BLOC", () {
    Widget _makeTestableWidget(Widget body) {
      return MultiProvider(
        providers: [
          BlocProvider<MovieWatchlistBloc>(
            create: (_) => mockMovieWatchlistBloc,
          ),
          BlocProvider<TvSeriesWatchlistBloc>(
            create: (_) => mockTvSeriesWatchlistBloc,
          ),
          BlocProvider<MovieDetailBloc>(
            create: (_) => mockMovieDetailBloc,
          ),
          BlocProvider<MovieRecommendationBloc>(
            create: (_) => mockMovieRecommendationBloc,
          ),
          BlocProvider<TvSeriesDetailBloc>(
            create: (_) => mockTvDetailBloc,
          ),
          BlocProvider<TvSeriesRecommendationBloc>(
            create: (_) => mockTvRecommendationBloc,
          ),
          BlocProvider<TvSeriesEpisodeBloc>(
            create: (_) => mockTvEpisodeBloc,
          ),
        ],
        child: MaterialApp(
          home: body,
        ),
      );
    }

    setUp(() {
      tail.registerFallbackValue(MovieWatchlistStateFake());
      tail.registerFallbackValue(MovieWatchlistEventFake());
      tail.registerFallbackValue(TvSeriesWatchlistStateFake());
      tail.registerFallbackValue(TvSeriesWatchlistEventFake());
      tail.registerFallbackValue(MovieDetailStateFake());
      tail.registerFallbackValue(MovieDetailEventFake());
      tail.registerFallbackValue(MovieRecommendationStateFake());
      tail.registerFallbackValue(MovieRecommendationEventFake());
      tail.registerFallbackValue(TvDetailStateFake());
      tail.registerFallbackValue(TvDetailEventFake());
      tail.registerFallbackValue(TvRecommendationStateFake());
      tail.registerFallbackValue(TvRecommendationEventFake());
      tail.registerFallbackValue(TvEpisodeStateFake());
      tail.registerFallbackValue(TvEpisodeEventFake());
    });
    group("MOVIES", () {
      testWidgets(
          'Watchlist button should display add icon when movie not added to watchlist',
              (WidgetTester tester) async {
            tail
                .when(() => mockMovieDetailBloc.state)
                .thenReturn(const MovieDetailHasData(testMovieDetail));
            tail
                .when(() => mockMovieRecommendationBloc.state)
                .thenReturn(const MovieRecommendationHasData(<Movie>[]));
            tail
                .when(() => mockMovieWatchlistBloc.state)
                .thenReturn(const MovieWatchlistStatusHasData(false));

            final watchlistButtonIcon = find.byIcon(Icons.add);

            await tester.pumpWidget(_makeTestableWidget(
                MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: true))));

            expect(watchlistButtonIcon, findsOneWidget);
          });

      testWidgets(
          'Watchlist button should dispay check icon when movie is added to wathclist',
              (WidgetTester tester) async {
            tail
                .when(() => mockMovieDetailBloc.state)
                .thenReturn(const MovieDetailHasData(testMovieDetail));
            tail
                .when(() => mockMovieRecommendationBloc.state)
                .thenReturn(const MovieRecommendationHasData(<Movie>[]));
            tail
                .when(() => mockMovieWatchlistBloc.state)
                .thenReturn(const MovieWatchlistStatusHasData(true));

            final watchlistButtonIcon = find.byIcon(Icons.check);

            await tester.pumpWidget(_makeTestableWidget(
                MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: true))));

            expect(watchlistButtonIcon, findsOneWidget);
          });
    });

    group("TV SERIES", () {
      testWidgets(
          'Watchlist button should display add icon when tv not added to watchlist',
              (WidgetTester tester) async {
            tail
                .when(() => mockTvDetailBloc.state)
                .thenReturn(const TvDetailHasData(testTvDetail));
            tail
                .when(() => mockTvRecommendationBloc.state)
                .thenReturn(const TvSeriesRecommendationHasData(<TvSeries>[]));
            tail
                .when(() => mockTvEpisodeBloc.state)
                .thenReturn(const TvEpisodeHasData(<Episode>[]));
            tail
                .when(() => mockTvSeriesWatchlistBloc.state)
                .thenReturn(const TvSeriesWatchlistStatusHasData(false));

            final watchlistButtonIcon = find.byIcon(Icons.add);

            await tester.pumpWidget(_makeTestableWidget(
                MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: false))));

            expect(watchlistButtonIcon, findsOneWidget);
          });

      testWidgets(
          'Watchlist button should dispay check icon when tv is added to wathclist',
              (WidgetTester tester) async {
            tail
                .when(() => mockTvDetailBloc.state)
                .thenReturn(const TvDetailHasData(testTvDetail));
            tail
                .when(() => mockTvRecommendationBloc.state)
                .thenReturn(const TvSeriesRecommendationHasData(<TvSeries>[]));
            tail
                .when(() => mockTvEpisodeBloc.state)
                .thenReturn(const TvEpisodeHasData(<Episode>[]));
            tail
                .when(() => mockTvSeriesWatchlistBloc.state)
                .thenReturn(const TvSeriesWatchlistStatusHasData(true));

            final watchlistButtonIcon = find.byIcon(Icons.check);

            await tester.pumpWidget(_makeTestableWidget(
                MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: false))));

            expect(watchlistButtonIcon, findsOneWidget);
          });
    });
  });
}
