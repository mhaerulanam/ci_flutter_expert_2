import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_episode.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_episode_bloc_test.mocks.dart';

@GenerateMocks([GetTvEpisode])
main() {
  late MockGetTvEpisode mockGetTvEpisode;
  late TvSeriesEpisodeBloc tvSeriesEpisodeBloc;

  setUp(() {
    mockGetTvEpisode = MockGetTvEpisode();
    tvSeriesEpisodeBloc = TvSeriesEpisodeBloc(mockGetTvEpisode);
  });

  const idTv = 1;
  const idEpisode = 1;

  test("initial state should be empty", () {
    expect(tvSeriesEpisodeBloc.state, TvEpisodeEmpty());
  });

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvEpisode.execute(idTv, idEpisode))
          .thenAnswer((_) async => Right(testTvEpisodeList));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesEpisodeGetEvent(idTv, idEpisode)),
    expect: () => [TvEpisodeLoading(), TvEpisodeHasData(testTvEpisodeList)],
    verify: (bloc) {
      verify(mockGetTvEpisode.execute(idTv, idEpisode));
    },
  );

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetTvEpisode.execute(idTv, idEpisode))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesEpisodeGetEvent(idTv, idEpisode)),
    expect: () => [TvEpisodeLoading(), const TvEpisodeError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvEpisode.execute(idTv, idEpisode));
    },
  );
}