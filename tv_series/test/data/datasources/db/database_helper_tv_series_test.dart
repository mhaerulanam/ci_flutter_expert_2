import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/db/database_helper_tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'database_helper_tv_series_test.mocks.dart';


@GenerateMocks([
  DatabaseHelperTvSeries,
])
void main() {
  late MockDatabaseHelperTvSeries mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelperTvSeries();
  });

  group("Tv Series", () {
    group('save watchlist', () {
      test('should return success message when insert to database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await mockDatabaseHelper.insertWatchlist(testTvSeriesTable);
        // assert
        expect(result, 1);
      });

      test('should throw DatabaseException when insert to database is failed',
          () async {
        var newTestTvSeriesTable = testTvSeriesTable;
        // arrange
        when(mockDatabaseHelper.insertWatchlist(newTestTvSeriesTable))
            .thenAnswer((_) async => 0);
        // act
        final result =
            await mockDatabaseHelper.insertWatchlist(newTestTvSeriesTable);
        // assert
        expect(result, 0);
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove to database is success',
              () async {
            // arrange
            when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
                .thenAnswer((_) async => 1);
            // act
            final result = await mockDatabaseHelper.removeWatchlist(testTvSeriesTable);
            // assert
            expect(result, 1);
          });

      test('should throw DatabaseException when remove to database is failed',
              () async {
            var newTestTvSeriesTable = testTvSeriesTable;
            // arrange
            when(mockDatabaseHelper.removeWatchlist(newTestTvSeriesTable))
                .thenAnswer((_) async => 0);
            // act
            final result =
            await mockDatabaseHelper.removeWatchlist(newTestTvSeriesTable);
            // assert
            expect(result, 0);
          });
    });
  });

}
