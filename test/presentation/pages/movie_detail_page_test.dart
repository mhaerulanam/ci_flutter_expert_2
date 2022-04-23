import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;
  late MockTvDetailNotifier mockTvNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
    mockTvNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieDetailNotifier>(
          create: (_) => mockNotifier,
        ),
        ChangeNotifierProvider<TvSeriesDetailNotifier>(
          create: (_) => mockTvNotifier,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: true))));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: true))));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: true))));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: true))));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });


  group("TV SERIES", () {
    testWidgets(
        'Watchlist button should display add icon when tv not added to watchlist',
            (WidgetTester tester) async {
          when(mockTvNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeries).thenReturn(testTvDetail);
          when(mockTvNotifier.recommendationState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
          when(mockTvNotifier.episodeState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvEpisode).thenReturn(<Episode>[]);
          when(mockTvNotifier.isAddedToWatchlistTvSeries).thenReturn(false);

          final watchlistButtonIcon = find.byIcon(Icons.add);

          await tester.pumpWidget(_makeTestableWidget(
              MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: false))));

          expect(watchlistButtonIcon, findsOneWidget);
        });

    testWidgets(
        'Watchlist button should dispay check icon when tv is added to wathclist',
            (WidgetTester tester) async {
          when(mockTvNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeries).thenReturn(testTvDetail);
          when(mockTvNotifier.recommendationState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
          when(mockTvNotifier.episodeState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvEpisode).thenReturn(<Episode>[]);
          when(mockTvNotifier.isAddedToWatchlistTvSeries).thenReturn(true);

          final watchlistButtonIcon = find.byIcon(Icons.check);

          await tester.pumpWidget(_makeTestableWidget(
              MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: false))));

          expect(watchlistButtonIcon, findsOneWidget);
        });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
            (WidgetTester tester) async {
          when(mockTvNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeries).thenReturn(testTvDetail);
          when(mockTvNotifier.recommendationState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
          when(mockTvNotifier.episodeState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvEpisode).thenReturn(<Episode>[]);
          when(mockTvNotifier.isAddedToWatchlistTvSeries).thenReturn(false);
          when(mockTvNotifier.watchlistMessage).thenReturn('Added to Watchlist');

          final watchlistButton = find.byType(ElevatedButton);

          await tester.pumpWidget(_makeTestableWidget(
              MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: false))));

          expect(find.byIcon(Icons.add), findsOneWidget);

          await tester.tap(watchlistButton);
          await tester.pump();

          expect(find.byType(SnackBar), findsOneWidget);
          expect(find.text('Added to Watchlist'), findsOneWidget);
        });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
            (WidgetTester tester) async {
          when(mockTvNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeries).thenReturn(testTvDetail);
          when(mockTvNotifier.recommendationState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
          when(mockTvNotifier.episodeState).thenReturn(RequestState.Loaded);
          when(mockTvNotifier.tvEpisode).thenReturn(<Episode>[]);
          when(mockTvNotifier.isAddedToWatchlistTvSeries).thenReturn(false);
          when(mockTvNotifier.watchlistMessage).thenReturn('Failed');

          final watchlistButton = find.byType(ElevatedButton);

          await tester.pumpWidget(_makeTestableWidget(
              MovieDetailPage(args: MovieDetailArgs(id: 1, isMovie: false))));

          expect(find.byIcon(Icons.add), findsOneWidget);

          await tester.tap(watchlistButton);
          await tester.pump();

          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.text('Failed'), findsOneWidget);
        });
  });
}
