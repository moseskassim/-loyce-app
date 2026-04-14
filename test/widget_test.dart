import 'package:flutter_test/flutter_test.dart';
import 'package:loyce/main.dart';

void main() {
  testWidgets('App splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LoyceApp());

    // Verify that the splash screen or initial app state loads
    // Since LoyceApp starts with SplashScreen, we just check if it builds without error
    expect(find.byType(LoyceApp), findsOneWidget);
  });
}
