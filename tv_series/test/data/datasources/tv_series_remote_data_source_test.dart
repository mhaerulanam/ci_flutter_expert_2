// ignore_for_file: constant_identifier_names

import 'package:common/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/models/episode_response.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';


void main() {
  const API_KEY = 'api_key=3a58e4d37532f1d71684e4c31ffde139';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });
  
  group('get Now Playing Tvs', () {
    final stringJson = readJson('dummy_data/tv_on_the_air.json');
    final tTvList = TvSeriesResponse.fromJson(stringJson).results;

    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response(stringJson, 200));
          // act
          final result = await dataSource.getTvOnTheAir();
          // assert
          expect(result, equals(tTvList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvOnTheAir();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Tvs', () {
    final tTvList =
        TvSeriesResponse.fromJson(readJson('dummy_data/tv_popular.json')).results;

    test('should return list of tvs when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_popular.json'), 200));
          // act
          final result = await dataSource.getPopularTvSeries();
          // assert
          expect(result, tTvList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularTvSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Tvs', () {
    final tTvList =
        TvSeriesResponse.fromJson(readJson('dummy_data/tv_top_rated.json')).results;

    test('should return list of tvs when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedTvSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tv detail', () {
    const tId = 500;
    final tTvDetail =
    DetailTvSeriesModel.fromJson(readJson('dummy_data/tv_series_detail.json'));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeriesDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test(
        'should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvSeriesDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tv recommendations', () {
    final tTvList =
        TvSeriesResponse.fromJson(readJson('dummy_data/tv_recommendations.json'))
            .results;
    const tId = 500;

    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
          // act
          final result = await dataSource.getTvSeriesRecommendations(tId);
          // assert
          expect(result, equals(tTvList));
        });

    test(
        'should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvSeriesRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tvs', () {
    final tSearchResult = TvSeriesResponse.fromJson(
        readJson('dummy_data/tv_series_search.json'))
        .results;
    const tQuery = 'Halo';

    test('should return list of tvs when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/tv_series_search.json'), 200));
      // act
      final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.searchTv(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('episode tvs', () {
    final tEpisodeResult = EpisodeResponse.fromJson(
        readJson('dummy_data/tv_detail_episode.json'));
    const idTv = 1991;
    const season = 1;

    test('should return list of episode tvs when response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$idTv/season/$season?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_detail_episode.json'), 200));
          // act
          final result = await dataSource.getTvEpisode(idTv, season);
          // assert
          expect(result, tEpisodeResult);
        });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$idTv/season/$season?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvEpisode(idTv, season);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
