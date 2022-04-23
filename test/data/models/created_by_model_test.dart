import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/domain/entities/create_by.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCreateModel = CreatedByModel(
      id: 781,
      creditId: "52537c0a19c2957940194e17",
      name: "Paul Reiser",
      gender: 2,
      profilePath: "/v3e5TClep4ugMdU4qSRiKbvLr3B.jpg"
  );

  final tCreate = CreatedBy(
      id: 781,
      creditId: "52537c0a19c2957940194e17",
      name: "Paul Reiser",
      gender: 2,
      profilePath: "/v3e5TClep4ugMdU4qSRiKbvLr3B.jpg"
  );

  test('should be a subclass of Movie entity', () async {
    final result = tCreateModel.toEntity();
    expect(result, tCreate);
  });
}
