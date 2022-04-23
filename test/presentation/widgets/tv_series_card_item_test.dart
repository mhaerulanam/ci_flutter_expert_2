import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  var movieCard = TvSeriesCard(testTvSeries);

  testWidgets('Tv Series Card item should exist all', (WidgetTester tester) async {
    final txtName = find.text("Halo");
    final txtOverview = find.text(
        'Depicting an epic 26th-century conflict between humanity and an'
            'alien threat known as the Covenant, the series weaves deeply drawn'
            'personal stories with action, adventure and a richly imagined vision'
            'of the future');
    final image = find.byType(Image);

    await tester.pumpWidget(_makeTestableWidget(movieCard));
    await tester.pump();

    expect(txtName, findsOneWidget);
    expect(txtOverview, findsOneWidget);
    expect(image, findsOneWidget);
  });
}
