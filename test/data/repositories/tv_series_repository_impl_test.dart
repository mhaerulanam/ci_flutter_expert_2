import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import '../../../movie/lib/data/models/episode_response.dart';
import '../../../common/lib/common/exception.dart';
import '../../../common/lib/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvModel = TvSeriesModel(
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

  final tTvEpisode = Episode(
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

  final tTvModelList = <TvSeriesModel>[tTvModel];
  final tTvList = <TvSeries>[tTv];
  final tTvEpisodeList = <Episode>[tTvEpisode];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvOnTheAir())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getTvOnTheAir();
          // assert
          verify(mockRemoteDataSource.getTvOnTheAir());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvOnTheAir())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvOnTheAir();
          // assert
          verify(mockRemoteDataSource.getTvOnTheAir());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvOnTheAir())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvOnTheAir();
          // assert
          verify(mockRemoteDataSource.getTvOnTheAir());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tv Series', () {
    test('should return movie list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated tv series', () {
    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });
  //
  // group('Get tv series Detail', () {
  //   final tId = 1;
  //
  //   test(
  //       'should return Server Failure when the call to remote data source is unsuccessful',
  //           () async {
  //         // arrange
  //         when(mockRemoteDataSource.getTvSeriesDetail(tId))
  //             .thenThrow(ServerException());
  //         // act
  //         final result = await repository.getTvSeriesDetail(tId);
  //         // assert
  //         verify(mockRemoteDataSource.getTvSeriesDetail(tId));
  //         expect(result, equals(Left(ServerFailure(''))));
  //       });
  //
  //   test(
  //       'should return connection failure when the device is not connected to internet',
  //           () async {
  //         // arrange
  //         when(mockRemoteDataSource.getTvSeriesDetail(tId))
  //             .thenThrow(SocketException('Failed to connect to the network'));
  //         // act
  //         final result = await repository.getTvSeriesDetail(tId);
  //         // assert
  //         verify(mockRemoteDataSource.getTvSeriesDetail(tId));
  //         expect(result,
  //             equals(Left(ConnectionFailure('Failed to connect to the network'))));
  //       });
  // });

  group('Get Tv Detail', () {
    const tId = 1991;
    final tTvResponse = DetailTvSeriesModel(
      seasons:[],
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
      genres: [],
      firstAirDate: "2006-09-18",
      lastAirDate: "2021-10-19",
      episodeRunTime: const [60, 42],
      homepage: "http://www.rachaelrayshow.com/",
      type: "Talk Show",
      tagline: "",
      status: "Returning Series",
      inProduction: true,
      numberOfSeasons: 13,
      numberOfEpisodes: 1051,
      languages: const ["en"],
      nextEpisodeToAir: const {
        "air_date": "2021-10-20",
        "episode_number": 28,
        "id": 3286382,
        "name":
        "Jeremy Sisto Dishes on \"Law & Order\" Revival + Rach's Greek-Style Burger Patties",
        "overview":
        "\"FBI's\" Jeremy Sisto is talking about the newest season of the hit show and dishing on the \"Law & Order\" revival. Plus, makeovers are BACK! Clinton Kelly is hooking up an inspiring Philadelphia police officer with our first makeover back in the studio. Later, a real-life spy shares safety tips. For dinner, Rachael's making delish Greek-style burger patties.",
        "production_code": "",
        "season_number": 16,
        "still_path": null,
        "vote_average": 0.0,
        "vote_count": 0
      },
    );

    test(
        'should return Tv data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenAnswer((_) async => tTvResponse);
          // act
          final result = await repository.getTvSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Right(testTvDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId)).thenThrow(
              const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get tv series Recommendations', () {
    final tTvList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
              .thenAnswer((_) async => tTvList);
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Search tv series', () {
    final tQuery = 'Halo';

    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTv(tQuery))
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.searchTv(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTv(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTv(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTv(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTv(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTvSeries(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tvs', () {
    test('should return list of Tv', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });

  group('Get Tv Episodes', () {
    final tTvEpisode = EpisodeResponse(
      id: "52571e1819c2957114101a1a",
      airDate: DateTime(2006, 09, 18),
      episodes: tTvEpisodeList,
      name: "Season 1",
      overview: "",
      episodeResponseId: 1438,
      posterPath: null,
      seasonNumber: 1,
    );
    const tId = 500;
    const tEpisode = 0;

    test('should return data (episode tv list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvEpisode(tId, tEpisode))
              .thenAnswer((_) async => tTvEpisode);
          // act
          final result = await repository.getTvEpisode(tId, tEpisode);
          // assert
          verify(mockRemoteDataSource.getTvEpisode(tId, tEpisode));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvEpisodeList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvEpisode(tId, tEpisode))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvEpisode(tId, tEpisode);
          // assert
          verify(mockRemoteDataSource.getTvEpisode(tId, tEpisode));
          expect(
              result,
              equals(
                  Left(ServerFailure('Failed to connect to the server'))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvEpisode(tId, tEpisode)).thenThrow(
              const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvEpisode(tId, tEpisode);
          // assert
          verify(mockRemoteDataSource.getTvEpisode(tId, tEpisode));
          expect(
              result,
              equals(Left(
                  ConnectionFailure('Failed to connect to the network'))));
        });
  });
}


