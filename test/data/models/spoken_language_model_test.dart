import 'package:ditonton/data/models/spoken_language_model.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSpokenModel = SpokenLanguageModel(
      name: "English",
      englishName: "English",
      iso6391: "en"
  );

  final tSpoken = SpokenLanguage(
      name: "English",
      englishName: "English",
      iso6391: "en"
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSpokenModel.toEntity();
    expect(result, tSpoken);
  });
}
