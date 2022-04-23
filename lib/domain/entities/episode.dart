import 'dart:convert';

import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
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

  final String? airDate;
  final num? episodeNumber;
  final num? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final num? seasonNumber;
  final String? stillPath;
  final num? voteAverage;
  final num? voteCount;

  factory Episode.fromJson(String str) => Episode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
        airDate: json["air_date"],
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

  Map<String, dynamic> toMap() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

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
