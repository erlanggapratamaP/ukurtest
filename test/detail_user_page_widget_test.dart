import 'package:fake_json/presentation/pages/detail_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('detail page created', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: DetailUserPage(),
    );
    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('data_detail')), findsOneWidget);
  });
}
