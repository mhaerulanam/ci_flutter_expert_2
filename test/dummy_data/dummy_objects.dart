import 'package:ditonton/data/models/episode_response.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testWatchlistMovieList = [testWatchlistMovie];
final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};


final testTvSeries = TvSeries(
    backdropPath: '/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg',
    firstAirDate: '2022-03-24',
    genreIds: [
      10759,
      10765
    ],
    id: 52814,
    name: 'Halo',
    originCountry: [
      "US"
    ],
    originalLanguage: 'en',
    originalName: 'Halo',
    overview: 'Depicting an epic 26th-century conflict between humanity and an'
        'alien threat known as the Covenant, the series weaves deeply drawn'
        'personal stories with action, adventure and a richly imagined vision'
        'of the future',
    popularity: 6106.197,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.8,
    voteCount: 376
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = DetailTvSeries(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    episodeRunTime: [59],
    firstAirDate: "",
    genres: [
      Genre(id: 10759, name: 'Action & Adventure')
    ],
    homepage: "https://www.paramountplus.com/shows/halo/",
    id: 52814,
    inProduction: true,
    languages: [
      "en",
      "af",
      "eo",
      "pt",
      "ug"
    ],
    lastAirDate: "2022-04-07",
    name: "Halo",
    nextEpisodeToAir: {
      3619243,
    },
    numberOfEpisodes: 9,
    numberOfSeasons: 1,
    originCountry: [
      "US"
    ],
    originalLanguage: "en",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an"
        "alien threat known as the Covenant, the series weaves deeply drawn"
        "personal stories with action, adventure and a richly imagined vision"
        "of the future",
    popularity: 6106.197,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    seasons: [
    ],
    status: "Returning Series",
    tagline: "Find the Halo, win the war.",
    type:  "Scripted",
    voteAverage: 8.8,
    voteCount: 378
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeriesList = [testWatchlistTvSeries];

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

///
/// EPISODE
///
final testTvEpisode = Episode(
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
final testTvEpisodeList = <Episode>[testTvEpisode];
final testTvEpisodeResponse = EpisodeResponse(
  id: "52571e1819c2957114101a1a",
  airDate: DateTime(2006, 09, 18),
  episodes: testTvEpisodeList,
  name: "Season 1",
  overview: "",
  episodeResponseId: 1438,
  posterPath: null,
  seasonNumber: 1,
);


final testTvDetail = DetailTvSeries(
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
