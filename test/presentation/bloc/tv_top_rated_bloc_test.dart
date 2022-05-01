import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvs;
  late TvSeriesTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvSeries();
    tvTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvs);
  });

  test("initial state should be empty", () {
    expect(tvTopRatedBloc.state, TvSeriesTopRatedEmpty());
  });

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
  final tTvSeriesList = <TvSeries>[tTv];

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvSeriesTopRatedGetEvent()),
    expect: () => [TvSeriesTopRatedLoading(), TvSeriesTopRatedHasData(tTvSeriesList)],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvSeriesTopRatedGetEvent()),
    expect: () =>
    [TvSeriesTopRatedLoading(), const TvSeriesTopRatedError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}