import 'package:common/common/failure.dart';
import 'package:common/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';
import 'package:tv_series/presentation/provider/tv_series_list_notifier.dart';

import '../../helpers/test_helper.mocks.dart';

@GenerateMocks([GetPopularTvSeries, GetTvOnTheAir, GetTopRatedTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
      getTvOnTheAir: mockGetTvOnTheAir,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

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

  group('on the air tv series', () {
    test('initialState should be Empty', () {
      expect(provider.tvOnTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      provider.fetchTvOnTheAir();
      // assert
      verify(mockGetTvOnTheAir.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      provider.fetchTvOnTheAir();
      // assert
      expect(provider.tvOnTheAirState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchTvOnTheAir();
      // assert
      expect(provider.tvOnTheAirState, RequestState.Loaded);
      expect(provider.tvOnTheAir, tTvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvOnTheAir();
      // assert
      expect(provider.tvOnTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvs);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
