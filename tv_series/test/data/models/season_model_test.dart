import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/season.dart';

void main() {
  const tSeasonModel = SeasonModel(
      id : 1433,
      name : "Season 1",
      overview : "",
      airDate: "1992-09-23",
      posterPath: "/rDXUk0AorokZXJJKdKwYcwzEdMI.jpg",
      seasonNumber: 1,
      episodeCount: 22
  );

  const tSeason = Season(
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
