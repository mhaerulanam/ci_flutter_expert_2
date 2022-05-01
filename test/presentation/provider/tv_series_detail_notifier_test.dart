import 'package:dartz/dartz.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_episode.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetTvEpisode,
])

void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvEpisode mockGetTvEpisode;
  late MockGetTvSeriesDetail mockGetTvDetail;
  late MockGetTvSeriesRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlist;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvEpisode = MockGetTvEpisode();
    mockGetTvDetail = MockGetTvSeriesDetail();
    mockGetTvRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTvSeries();
    mockSaveWatchlist = MockSaveWatchlistTvSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTvSeries();
    provider = TvSeriesDetailNotifier(
      getTvEpisode: mockGetTvEpisode,
      getTvSeriesDetail: mockGetTvDetail,
      getTvSeriesRecommendations: mockGetTvRecommendations,
      getWatchListStatusTvSeries: mockGetWatchlistStatus,
      saveWatchlistTvSeries: mockSaveWatchlist,
      removeWatchlistTvSeries: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  const tId = 1991;
  const tIdEpisode = 1;

  final tTv = TvSeries(
    voteCount: 29,
    voteAverage: 5.8,
    backdropPath: '/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg',
    posterPath: '/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg',
    popularity: 2907.317,
    overview:
    "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio.",
    originalName: 'Rachael Ray',
    originalLanguage: 'en',
    originCountry: const ['US'],
    name: 'Rachael Ray',
    id: 1991,
    genreIds: const [10767],
    firstAirDate: '2006-09-18',
  );
  final tTvs = <TvSeries>[tTv];

  final tEpisode = Episode(
    airDate: "2006-09-18",
    episodeNumber: 1,
    id: 24809,
    name: "Rachael's Premiere",
    overview: "",
    productionCode: "",
    seasonNumber: 1,
    stillPath: null,
    voteAverage: 0.0,
    voteCount: 0.0,
  );
  final tEpisodes = [tEpisode];

  void _arrangeUsecase() {
    when(mockGetTvEpisode.execute(tId, tIdEpisode))
        .thenAnswer((_) async => Right(testTvEpisodeList));
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvEpisode.execute(tId, tIdEpisode));
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, testTvDetail);
      expect(listenerCallCount, 4);
    });

    test('should change recommendation tvs when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvSeriesDetail(tId);
          // assert
          expect(provider.tvSeriesState, RequestState.Loaded);
          expect(provider.tvSeriesRecommendations, tTvs);
        });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvSeriesRecommendations, tTvs);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvSeriesDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.tvSeriesRecommendations, tTvs);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      when(mockGetTvEpisode.execute(tId, tIdEpisode))
          .thenAnswer((_) async => Right(tEpisodes));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });
  group('Get Episode Tv From Beginning', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvEpisode.execute(tId, tIdEpisode));
      expect(provider.tvEpisode, tEpisodes);
    });

    test('should update episode state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvSeriesDetail(tId);
          // assert
          expect(provider.episodeState, RequestState.Loaded);
          expect(provider.tvEpisode, tEpisodes);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      when(mockGetTvEpisode.execute(tId, tIdEpisode))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.episodeState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Get Episode Tv To The Point', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvEpisode(tId, tIdEpisode);
      // assert
      verify(mockGetTvEpisode.execute(tId, tIdEpisode));
      expect(provider.tvEpisode, tEpisodes);
    });

    test('should update episode state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvEpisode(tId, tIdEpisode);
          // assert
          expect(provider.episodeState, RequestState.Loaded);
          expect(provider.tvEpisode, tEpisodes);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvEpisode.execute(tId, tIdEpisode))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvEpisode(tId, tIdEpisode);
      // assert
      expect(provider.episodeState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusTVSeries(1);
      // assert
      expect(provider.isAddedToWatchlistTvSeries, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTvSeries(testTvDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTvSeries(testTvDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTvSeries(testTvDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlistTvSeries, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTvSeries(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));
      when(mockGetTvEpisode.execute(tId, tIdEpisode))
          .thenAnswer((_) async => Right(tEpisodes));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}