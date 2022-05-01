import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

void main() {
  const tTvModel = TvSeriesModel(
    voteCount: 213,
    voteAverage: 7.3,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    popularity: 4.5,
    overview: 'overview',
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: ['originCountry'],
    name: 'name',
    id: 1,
    genreIds: [1, 2, 3],
    firstAirDate: 'firstAirDate',
  );

  final tTv = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 4.5,
    posterPath: 'posterPath',
    voteAverage: 7.3,
    voteCount: 213,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: const ['originCountry'],
    name: 'name',
    firstAirDate: 'firstAirDate',
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
