import 'package:bloc_test/bloc_test.dart';
import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';
import 'package:tv_series/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';

import '../../helpers/test_helper.mocks.dart';


@GenerateMocks([GetTvOnTheAir])
main() {
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late TvOnTheAirBloc tvOnTheAirBloc;

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetTvOnTheAir);
  });

  test("initial state should be empty", () {
    expect(tvOnTheAirBloc.state, TvOnTheAirEmpty());
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

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(TvOnTheAirGetEvent()),
    expect: () => [TvOnTheAirLoading(), TvOnTheAirHasData(tTvList)],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(TvOnTheAirGetEvent()),
    expect: () =>
    [TvOnTheAirLoading(), const TvOnTheAirError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );
}