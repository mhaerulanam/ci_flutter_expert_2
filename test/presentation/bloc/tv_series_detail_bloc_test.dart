import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvSeriesDetailBloc tvDetailBloc;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvDetailBloc = TvSeriesDetailBloc(getTvDetail: mockGetTvSeriesDetail);
  });

  test("initial state should be empty", () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  const tTvId = 1;

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(tTvId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const GetTvDetailEvent(tTvId)),
    expect: () => [TvDetailLoading(), TvDetailHasData(testTvSeriesDetail)],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(tTvId));
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(tTvId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const GetTvDetailEvent(tTvId)),
    expect: () => [TvDetailLoading(), const TvDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(tTvId));
    },
  );
}