import 'package:equinox/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// §62 acceptance flow on a real device/emulator. Runs against the REAL local
// database (seeded on first launch). The camera/scanner leg is manual-only
// (needs a physical QR + UPI apps); everything downstream of a saved payment
// is driven here: dashboard → history → detail → savings → analytics →
// reports → pending inbox → data screen.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Device streams (seed insert) land asynchronously — poll instead of
  /// assuming first-frame data.
  Future<void> waitFor(Finder f, WidgetTester t) async {
    for (var i = 0; i < 30; i++) {
      await t.pump(const Duration(seconds: 1));
      if (f.evaluate().isNotEmpty) return;
    }
    throw StateError('timeout waiting for $f');
  }

  /// Category tiles reuse nav icons — scope taps to the bar itself.
  Future<void> navTap(WidgetTester t, IconData icon) async {
    await t.tap(find.descendant(
        of: find.byType(NavigationBar), matching: find.byIcon(icon)));
    await t.pumpAndSettle();
  }

  testWidgets('device flow: onboard to reports', (t) async {
    app.main(); // real entrypoint: seeding, bindings, ProviderScope
    await t.pumpAndSettle();

    await t.tap(find.text('GET STARTED'));
    await waitFor(find.text('₹24,860'), t); // seed landed in real SQLite
    expect(find.text('TOTAL SPENDING'), findsOneWidget);

    // History: search narrows, chip filters, detail opens.
    await navTap(t, Icons.receipt_long_outlined);
    await waitFor(find.byType(TextField), t);
    await t.enterText(find.byType(TextField), 'Shell');
    await t.pumpAndSettle();
    expect(find.text('D-Mart'), findsNothing);
    await t.enterText(find.byType(TextField), '');
    await t.pumpAndSettle();
    await t.tap(find.text('Food'));
    await t.pumpAndSettle();
    await t.tap(find.text('Shree Krishna Cafe').first);
    await t.pumpAndSettle();
    expect(find.text('UPI ID'), findsOneWidget);
    await t.binding.handlePopRoute(); // dismiss detail sheet (system back)
    await t.pumpAndSettle();

    // Savings: open, add-sheet validates.
    await navTap(t, Icons.home_outlined);
    await t.pumpAndSettle();
    await t.tap(find.text('OPEN ›'));
    await t.pumpAndSettle();
    expect(find.text('ADD SAVINGS'), findsOneWidget);

    // Analytics: step months, touch chart.
    await t.pageBack();
    await t.pumpAndSettle();
    await navTap(t, Icons.bar_chart_outlined);
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.chevron_left));
    await t.pumpAndSettle();

    // Reports: archive → detail.
    await navTap(t, Icons.home_outlined);
    await t.scrollUntilVisible(find.text('VIEW REPORT'), 500);
    await t.pumpAndSettle();
    await t.tap(find.text('VIEW REPORT'));
    await t.pumpAndSettle();
    expect(find.text('REPORTS'), findsOneWidget);

    // Profile: data management + version visible.
    await t.pageBack();
    await t.pumpAndSettle();
    await navTap(t, Icons.person_outline);
    await t.pumpAndSettle();
    expect(find.text('Data management'), findsOneWidget);
    expect(find.text('1.0.0+1'), findsOneWidget);
  });
}
