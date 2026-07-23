import 'package:flutter_test/flutter_test.dart';
import 'package:cricscore_app/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // Allow async init (Firebase/in-app update) to settle without failing the smoke test.
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(MyApp), findsOneWidget);
  });
}
