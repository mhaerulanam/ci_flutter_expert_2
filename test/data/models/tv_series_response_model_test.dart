
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
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
  final tTvResponseModel = TvSeriesResponse(
    page: 1,
    totalPages: 60,
    totalResults: 1190,
    results: <TvSeriesModel>[tTvModel],
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final jsonMap = (readJson('dummy_data/tv_on_the_air.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toMap();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "backdrop_path": "/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg",
            "first_air_date": "2006-09-18",
            "genre_ids": [10767],
            "id": 1991,
            "name": "Rachael Ray",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Rachael Ray",
            "overview":
            "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio.",
            "popularity": 2907.317,
            "poster_path": "/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg",
            "vote_average": 5.8,
            "vote_count": 29
          }
        ],
        "total_pages": 60,
        "total_results": 1190,
      };
      expect(result, expectedJsonMap);
    });
  });
}


