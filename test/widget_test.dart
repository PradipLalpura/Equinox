// Phase 1 smoke tests: onboarding → nav shell renders offline.
// StreamProvider overridden with seed: widget tests never touch real SQLite.
import 'package:equinox/application/providers.dart';
import 'package:equinox/core/widgets/ui.dart';
import 'package:equinox/domain/models.dart';
import 'package:equinox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderScope testApp() => ProviderScope(
  overrides: [
    txListProvider.overrideWith((_) => Stream.value(seedTx)),
    savingsListProvider.overrideWith((_) => Stream.value(seedSavings)),
    goalsProvider.overrideWith((_) => const Stream.empty()),
    savingsTargetProvider.overrideWith((_) => Stream.value(5000)),
  ],
  child: const EquinoxRoot(),
);

void main() {
  testWidgets('onboarding shows, GET STARTED opens dashboard', (t) async {
    await t.pumpWidget(testApp());
    expect(find.text('Your payments.\nRemembered.'), findsOneWidget);
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    expect(find.text('EQUINOX'), findsWidgets);
    expect(find.text('TOTAL SPENDING'), findsOneWidget);
  });

  testWidgets('bottom nav switches tabs', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.receipt_long_outlined));
    await t.pumpAndSettle();
    expect(find.text('HISTORY'), findsWidgets);
  });

  testWidgets('history search narrows results', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.receipt_long_outlined));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField), 'D-Mart');
    await t.pumpAndSettle();
    expect(find.text('D-Mart'), findsWidgets); // row + search field text
    expect(find.text('Shell Ranip'), findsNothing);
  });

  testWidgets('category chip filters history', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.receipt_long_outlined));
    await t.pumpAndSettle();
    await t.tap(find.text('Petrol'));
    await t.pumpAndSettle();
    expect(find.text('Shell Ranip'), findsWidgets);
    expect(find.text('D-Mart'), findsNothing);
  });

  testWidgets('tapping a transaction opens detail sheet', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.receipt_long_outlined));
    await t.pumpAndSettle();
    await t.tap(find.text('Shree Krishna Cafe').first); // newest = t01
    await t.pumpAndSettle();
    expect(find.text('UPI ID'), findsOneWidget);
    expect(find.text('shreekrishna@upi'), findsOneWidget);
  });

  testWidgets('savings screen opens with month progress', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.text('OPEN ›'));
    await t.pumpAndSettle();
    expect(
      find.text('SAVED IN ${monthLabel(DateTime.now()).toUpperCase()}'),
      findsOneWidget,
    );
    expect(find.text('ADD SAVINGS'), findsOneWidget);
    expect(find.text('+ NEW GOAL'), findsOneWidget);
  });

  testWidgets('add sheet validates amount before save', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.text('OPEN ›'));
    await t.pumpAndSettle();
    await t.tap(find.text('ADD SAVINGS'));
    await t.pumpAndSettle();
    expect(find.text('ADD SAVINGS', skipOffstage: false), findsWidgets);
    await t.enterText(find.byType(TextField).first, 'abc');
    await t.pump();
    expect(
      t
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'SAVE'))
          .onPressed,
      isNull,
    );
    await t.enterText(find.byType(TextField).first, '500');
    await t.pump();
    expect(
      t
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'SAVE'))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('month stepper crosses into previous month', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.bar_chart_outlined));
    await t.pumpAndSettle();
    final now = DateTime.now();
    expect(find.text(monthLabel(now)), findsOneWidget);
    await t.tap(find.byIcon(Icons.chevron_left));
    await t.pumpAndSettle();
    expect(
      find.text(monthLabel(DateTime(now.year, now.month - 1))),
      findsOneWidget,
    );
  });

  testWidgets('chart tap selects the tapped day', (t) async {
    await t.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InteractiveChart(
            buckets: const [1000, 0, 680, 0, 0, 0, 450],
            counts: const [2, 0, 1, 0, 0, 0, 1],
            monday: DateTime(2026, 9, 21),
          ),
        ),
      ),
    );
    await t.pumpAndSettle();
    final center = t.getCenter(find.byKey(const Key('week-chart')));
    final size = t.getSize(find.byKey(const Key('week-chart')));
    await t.tapAt(Offset(center.dx - size.width / 2 + 20, center.dy));
    await t.pumpAndSettle();
    expect(find.text('Mon 21 · ₹1,000 · 2 transactions'), findsOneWidget);
  });

  testWidgets('teaser opens archive, month opens detail', (t) async {
    t.view.physicalSize = const Size(800, 2400);
    t.view.devicePixelRatio = 1.0;
    addTearDown(t.view.resetPhysicalSize);
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.text('VIEW REPORT'));
    await t.pumpAndSettle();
    expect(find.text('REPORTS'), findsOneWidget);
    expect(find.text('September 2026'), findsWidgets);
    await t.tap(find.text('September 2026').first);
    await t.pumpAndSettle();
    expect(find.text('SUMMARY'), findsOneWidget);
    expect(find.text('MONTH COMPARISON'), findsOneWidget);
    expect(find.text('EXPORT PDF'), findsOneWidget);
    expect(find.text('SHARE'), findsOneWidget);
  });

  testWidgets('pending inbox lists unconfirmed payments', (t) async {
    await t.pumpWidget(testApp());
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.person_outline).last); // nav bar, not the profile card
    await t.pumpAndSettle();
    expect(find.text('Pending review (1)'), findsOneWidget);
    await t.tap(find.text('Pending review (1)'));
    await t.pumpAndSettle();
    expect(find.text('PENDING REVIEW'), findsOneWidget);
    expect(find.text('Shree Krishna Cafe'), findsOneWidget);
  });
}
