import 'dart:convert';

import 'package:ditonton/data/models/production_country_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/spoken_language_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'created_by_model.dart';
import 'genre_model.dart';

// ignore: must_be_immutable
class DetailTvSeriesModel extends Equatable {
  DetailTvSeriesModel({
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  List<CreatedByModel>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<GenreModel>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  dynamic nextEpisodeToAir;
  List<Network>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Network>? productionCompanies;
  List<ProductionCountryModel>? productionCountries;
  List<SeasonModel>? seasons;
  List<SpokenLanguageModel>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  factory DetailTvSeriesModel.fromJson(String str) =>
      DetailTvSeriesModel.fromMap(json.decode(str));

  factory DetailTvSeriesModel.fromMap(Map<String, dynamic> json) =>
      DetailTvSeriesModel(
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"] == null
            ? null
            : List<CreatedByModel>.from(
                json["created_by"].map((x) => CreatedByModel.fromJson(x))),
        episodeRunTime: json["episode_run_time"] == null
            ? null
            : List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate:
            json["first_air_date"] == null ? null : json["first_air_date"],
        genres: json["genres"] == null
            ? null
            : List<GenreModel>.from(
                json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: json["languages"] == null
            ? null
            : List<String>.from(json["languages"].map((x) => x)),
        lastAirDate:
            json["last_air_date"] == null ? null : json["last_air_date"],
        lastEpisodeToAir: LastEpisodeToAir.fromMap(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: json["networks"] == null
            ? null
            : List<Network>.from(
                json["networks"].map((x) => Network.fromMap(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null
            ? null
            : List<Network>.from(
                json["production_companies"].map((x) => Network.fromMap(x))),
        productionCountries: json["production_countries"] == null
            ? null
            : List<ProductionCountryModel>.from(json["production_countries"]
                .map((x) => ProductionCountryModel.fromJson(x))),
        seasons: json["seasons"] == null
            ? null
            : List<SeasonModel>.from(
                json["seasons"].map((x) => SeasonModel.fromMap(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? null
            : List<SpokenLanguageModel>.from(json["spoken_languages"]
                .map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  DetailTvSeries toEntity() {
    return DetailTvSeries(
        backdropPath: backdropPath,
        episodeRunTime: episodeRunTime,
        firstAirDate: firstAirDate!,
        genres: genres!.map((genre) => genre.toEntity()).toList(),
        homepage: homepage,
        id: id,
        inProduction: inProduction,
        languages: languages!,
        lastAirDate: lastAirDate,
        name: name,
        nextEpisodeToAir: nextEpisodeToAir,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originCountry: originCountry!,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview!,
        popularity: popularity,
        posterPath: posterPath!,
        seasons: seasons!.map((genre) => genre.toEntity()).toList(),
        status: status,
        tagline: tagline!,
        type: type!,
        voteAverage: voteAverage!,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class LastEpisodeToAir extends Equatable {
  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  final DateTime? airDate;
  final int? episodeNumber;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;
  final num? voteAverage;
  final int? voteCount;

  factory LastEpisodeToAir.fromMap(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}

class Network extends Equatable {
  Network({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });

  final String? name;
  final int? id;
  final String? logoPath;
  final String? originCountry;

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"],
      );

  @override
  List<Object?> get props => [
        name,
        id,
        logoPath,
        originCountry,
      ];
}
