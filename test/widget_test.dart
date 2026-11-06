import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/app.dart';

void main() {
  testWidgets('Shopping app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShoppingApp());

    // Wait for the SplashScreen timer to finish.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.byType(ShoppingApp), findsOneWidget);
  });
}
