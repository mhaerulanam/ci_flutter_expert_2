import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/production_country_model.dart';
import 'package:tv_series/domain/entities/production_country.dart';

void main() {
  const tProductionModel = ProductionCountryModel(
      iso31661: "iso31661",
      name: "name",
  );

  const tProduction = ProductionCountry(
    iso31661: "iso31661",
    name: "name",
  );

  test('should be a subclass of Movie entity', () async {
    final result = tProductionModel.toEntity();
    expect(result, tProduction);
  });
}
