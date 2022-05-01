import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_recomendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
main() {
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendation;
  late TvSeriesRecommendationBloc tvRecommendationBloc;

  setUp(() {
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendations();
    tvRecommendationBloc = TvSeriesRecommendationBloc(
      getTvSeriesRecommendations: mockGetTvSeriesRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(tvRecommendationBloc.state, TvSeriesRecommendationEmpty());
  });

  const tTvId = 1;
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

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendation.execute(tTvId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetTvSeriesRecommendationEvent(tTvId)),
    expect: () => [TvSeriesRecommendationLoading(),
      TvSeriesRecommendationHasData(tTvSeriesList)],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendation.execute(tTvId));
    },
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'Should emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendation.execute(tTvId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetTvSeriesRecommendationEvent(tTvId)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      const TvSeriesRecommendationError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendation.execute(tTvId));
    },
  );
}