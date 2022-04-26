import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as tail;

import '../../helpers/test_helper.dart';


void main() {
  late MockTvTopRatedBloc mockTvTopRatedBloc;

  setUp(() {
    mockTvTopRatedBloc = MockTvTopRatedBloc();
  });
  group("BLOC", () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TvSeriesTopRatedBloc>(
        create: (_) => mockTvTopRatedBloc,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Page should display center text when nothing',
            (WidgetTester tester) async {
          tail.when(() => mockTvTopRatedBloc.state).thenReturn(TvSeriesTopRatedEmpty());

          final textFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

          expect(textFinder, findsOneWidget);
        });

    testWidgets('Page should display progress bar when loading',
            (WidgetTester tester) async {
          tail.when(() => mockTvTopRatedBloc.state).thenReturn(TvSeriesTopRatedLoading());

          final progressFinder = find.byType(CircularProgressIndicator);
          final centerFinder = find.byType(Center);

          await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

          expect(centerFinder, findsOneWidget);
          expect(progressFinder, findsOneWidget);
        });

    testWidgets('Page should display when data is loaded',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvTopRatedBloc.state)
              .thenReturn(const TvSeriesTopRatedHasData(<TvSeries>[]));

          final listViewFinder = find.byType(ListView);

          await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

          expect(listViewFinder, findsOneWidget);
        });

    testWidgets('Page should display text with message when Error',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvTopRatedBloc.state)
              .thenReturn(const TvSeriesTopRatedError('Error message'));

          final textFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

          expect(textFinder, findsOneWidget);
        });
  });
}
