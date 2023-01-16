import 'package:fake_json/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('userpage is created', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: UserPage(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('userpage check title widget', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: UserPage(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('title_view')), findsOneWidget);
  });

  testWidgets('userpage listView', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: UserPage(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('user_list_view')), findsOneWidget);
  });
  group('Testing search widget', () {
    testWidgets('userpage search bar check', (WidgetTester tester) async {
      const testWidget = MaterialApp(home: UserPage());

      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('searchbar_view')), findsOneWidget);
    });
  });

  group('Testing filter', () {
    testWidgets('userpage filter check', (WidgetTester tester) async {
      const testWidget = MaterialApp(home: UserPage());

      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('filter_widget')), findsOneWidget);
    });

    testWidgets('userpage filter on tap check', (WidgetTester tester) async {
      const testWidget = MaterialApp(home: UserPage());
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const Key('filter_widget')),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('filter_dialog_widget')), findsOneWidget);
    });
  });

  // testWidgets('userpage cardview on tap', (WidgetTester tester) async {
  //   const testWidget = MaterialApp(home: UserPage());

  //   await tester.pumpWidget(testWidget);
  //   await tester.pumpAndSettle();
  //   await tester.tap(
  //     find.byKey(const Key('on_tap_detail_user_page')),
  //   );
  //   await tester.pumpAndSettle();
  //   expect(find.byKey(const Key('detail_user_page')), findsOneWidget);
  // });
}
