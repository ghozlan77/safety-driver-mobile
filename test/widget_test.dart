
import 'package:flutter_test/flutter_test.dart';
import 'package:safety_driver_mobile/main.dart';

void main() {
  testWidgets('Welcome screen displays correctly', (tester) async {
    await tester.pumpWidget(const SafetyDriverApp());

    expect(find.text('Safety Driver'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });
}
