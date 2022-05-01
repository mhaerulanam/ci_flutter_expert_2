import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/spoken_language_model.dart';
import 'package:tv_series/domain/entities/spoken_language.dart';

void main() {
  const tSpokenModel = SpokenLanguageModel(
      name: "English",
      englishName: "English",
      iso6391: "en"
  );

  const tSpoken = SpokenLanguage(
      name: "English",
      englishName: "English",
      iso6391: "en"
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSpokenModel.toEntity();
    expect(result, tSpoken);
  });
}
