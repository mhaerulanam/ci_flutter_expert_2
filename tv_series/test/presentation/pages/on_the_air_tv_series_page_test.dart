import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as tail;
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:tv_series/presentation/pages/on_the_air_tv_series_page.dart';

import '../../helpers/test_helper.dart';


void main() {
  late MockTvOnTheAirBloc mockTvOnTheAirBloc;

  setUp(() {
    mockTvOnTheAirBloc = MockTvOnTheAirBloc();
  });
  group("BLOC", () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TvOnTheAirBloc>(
        create: (_) => mockTvOnTheAirBloc,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Page should display center text when nothing',
            (WidgetTester tester) async {
          tail.when(() => mockTvOnTheAirBloc.state).thenReturn(TvOnTheAirEmpty());

          final textFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

          expect(textFinder, findsOneWidget);
        });

    testWidgets('Page should display progress bar when loading',
            (WidgetTester tester) async {
          tail.when(() => mockTvOnTheAirBloc.state).thenReturn(TvOnTheAirLoading());

          final progressFinder = find.byType(CircularProgressIndicator);
          final centerFinder = find.byType(Center);

          await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

          expect(centerFinder, findsOneWidget);
          expect(progressFinder, findsOneWidget);
        });

    testWidgets('Page should display when data is loaded',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvOnTheAirBloc.state)
              .thenReturn(const TvOnTheAirHasData(<TvSeries>[]));

          final listViewFinder = find.byType(ListView);

          await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

          expect(listViewFinder, findsOneWidget);
        });

    testWidgets('Page should display text with message when Error',
            (WidgetTester tester) async {
          tail
              .when(() => mockTvOnTheAirBloc.state)
              .thenReturn(const TvOnTheAirError('Error message'));

          final textFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

          expect(textFinder, findsOneWidget);
        });
  });
}
