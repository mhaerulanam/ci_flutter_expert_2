import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  var movieCard = MovieCard(testMovie);

  testWidgets('Movie Card item should exist all', (WidgetTester tester) async {
    final txtTitle = find.text("Spider-Man");
    final txtOverview = find.text(
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.');
    final image = find.byType(Image);

    await tester.pumpWidget(_makeTestableWidget(movieCard));
    await tester.pump();

    expect(txtTitle, findsOneWidget);
    expect(txtOverview, findsOneWidget);
    expect(image, findsOneWidget);
  });
}
