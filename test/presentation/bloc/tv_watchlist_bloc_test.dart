import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries, GetWatchListStatusTvSeries, SaveWatchlistTvSeries, RemoveWatchlistTvSeries])
main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlist;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlist;
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatus = MockGetWatchListStatusTvSeries();
    mockSaveWatchlist = MockSaveWatchlistTvSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTvSeries();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      getWatchListsTvSeries: mockGetWatchlistTvSeries,
      getWatchListStatusTvSeries: mockGetWatchListStatus,
      saveWatchlistTvSeries: mockSaveWatchlist,
      removeWatchlistTvSeries: mockRemoveWatchlist,
    );
  });

  const tMovieId = 1;

  test("initial state should be empty", () {
    expect(tvSeriesWatchlistBloc.state, TvSeriesWatchlistEmpty());
  });

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testWatchlistTvSeriesList));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEventTv()),
    expect: () =>
    [TvSeriesWatchlistLoading(), TvSeriesWatchlistHasData(testWatchlistTvSeriesList)],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEventTv()),
    expect: () =>
    [TvSeriesWatchlistLoading(), const TvSeriesWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [HasData] when get status movie watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(tMovieId))
          .thenAnswer((_) async => true);
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusTvSeriesEvent(tMovieId)),
    expect: () => [const TvSeriesWatchlistStatusHasData(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tMovieId));
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [HasData] when get status tv watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(tMovieId))
          .thenAnswer((_) async => true);
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusTvSeriesEvent(tMovieId)),
    expect: () => [const TvSeriesWatchlistStatusHasData(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tMovieId));
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [HasData] when add tv item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Success"));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemTvSeriesEvent(testTvDetail)),
    expect: () => [const TvSeriesWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [HasData] when remove tv item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemTvSeriesEvent(testTvDetail)),
    expect: () => [const TvSeriesWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [error] when add tv item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemTvSeriesEvent(testTvDetail)),
    expect: () => [const TvSeriesWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'Should emit [error] when remove tv item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemTvSeriesEvent(testTvDetail)),
    expect: () => [const TvSeriesWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail));
    },
  );
}