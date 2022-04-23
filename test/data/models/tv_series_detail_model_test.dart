import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tDetailTvModel = DetailTvSeriesModel(
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
    lastAirDate: "2021-10-19",
  );

  final tDetaialTv = DetailTvSeries(
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
    lastAirDate: "2021-10-19",
  );

  test('should be a subclass of Tv entity', () async {
    final result = tDetailTvModel.toEntity();
    expect(result, tDetaialTv);
  });
}
