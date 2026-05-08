import 'package:flutter_test/flutter_test.dart';
import 'package:isango_app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const IsangoApp());
    expect(find.byType(IsangoApp), findsOneWidget);
  });
}
