import 'package:ditonton/data/models/production_country_model.dart';
import 'package:ditonton/domain/entities/production_country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProductionModel = ProductionCountryModel(
      iso31661: "iso31661",
      name: "name",
  );

  final tProduction = ProductionCountry(
    iso31661: "iso31661",
    name: "name",
  );

  test('should be a subclass of Movie entity', () async {
    final result = tProductionModel.toEntity();
    expect(result, tProduction);
  });
}
