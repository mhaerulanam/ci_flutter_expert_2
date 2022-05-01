import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as tail;
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';

import '../../helpers/test_helper.dart';

void main() {
  late MockTvPopularBloc mockTvPopularBloc;

  setUp(() {
    mockTvPopularBloc = MockTvPopularBloc();
  });

  group("BLOC", () {
    setUp(() {
      tail.registerFallbackValue(TvPopularEventFake());
      tail.registerFallbackValue(TvPopularStateFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TvSeriesPopularBloc>(
        create: (_) => mockTvPopularBloc,
        child: MaterialApp(
          home: body,
        ),
      );
    }


    testWidgets('Page should display center text when nothing',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvPopularBloc.state)
              .thenReturn(TvSeriesPopularEmpty());

          final textFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

          expect(textFinder, findsOneWidget);
        });

    testWidgets('Page should display center progress bar when loading',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvPopularBloc.state)
              .thenReturn(TvSeriesPopularLoading());

          final progressBarFinder = find.byType(CircularProgressIndicator);
          final centerFinder = find.byType(Center);

          await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

          expect(centerFinder, findsOneWidget);
          expect(progressBarFinder, findsOneWidget);
        });

    testWidgets('Page should display ListView when data is loaded',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvPopularBloc.state)
              .thenReturn(const TvSeriesPopularHasData(<TvSeries>[]));

          final listViewFinder = find.byType(ListView);

          await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

          expect(listViewFinder, findsOneWidget);
        });

    testWidgets('Page should display text with message when Error',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvPopularBloc.state)
              .thenReturn(const TvSeriesPopularError('Error message'));

          final textFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));

          expect(textFinder, findsOneWidget);
        });
  });
}
