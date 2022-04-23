import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
      id : 1433,
      name : "Season 1",
      overview : "",
      airDate: "1992-09-23",
      posterPath: "/rDXUk0AorokZXJJKdKwYcwzEdMI.jpg",
      seasonNumber: 1,
      episodeCount: 22
  );

  final tSeason = Season(
      id : 1433,
      name : "Season 1",
      overview : "",
      airDate: "1992-09-23",
      posterPath: "/rDXUk0AorokZXJJKdKwYcwzEdMI.jpg",
      seasonNumber: 1,
      episodeCount: 22
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
