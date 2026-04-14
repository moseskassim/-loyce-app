import 'package:flutter_test/flutter_test.dart';
import 'package:loyce/main.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LoyceApp());

    // Allow any initial animations or splash screen logic to settle
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify that the app builds without crashing
    expect(find.byType(LoyceApp), findsOneWidget);
  });
}
