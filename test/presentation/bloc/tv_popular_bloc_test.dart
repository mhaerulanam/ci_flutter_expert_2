import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
main() {
  late MockGetPopularTvSeries mockGetPopularTvs;
  late TvSeriesPopularBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvSeries();
    tvPopularBloc = TvSeriesPopularBloc(mockGetPopularTvs);
  });

  test("initial state should be empty", () {
    expect(tvPopularBloc.state, TvSeriesPopularEmpty());
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
  final tTvList = <TvSeries>[tTv];

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(TvSeriesPopularGetEvent()),
    expect: () => [TvSeriesPopularLoading(), TvSeriesPopularHasData(tTvList)],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(TvSeriesPopularGetEvent()),
    expect: () => [TvSeriesPopularLoading(), const TvSeriesPopularError('Server Failure')],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}