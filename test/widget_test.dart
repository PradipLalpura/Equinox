// Phase 1 smoke tests: onboarding → nav shell renders offline.
import 'package:equinox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('onboarding shows, GET STARTED opens dashboard', (t) async {
    await t.pumpWidget(const ProviderScope(child: EquinoxRoot()));
    expect(find.text('Your payments.\nRemembered.'), findsOneWidget);
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    expect(find.text('EQUINOX'), findsWidgets);
    expect(find.text('TOTAL SPENDING'), findsOneWidget);
  });

  testWidgets('bottom nav switches tabs', (t) async {
    await t.pumpWidget(const ProviderScope(child: EquinoxRoot()));
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.receipt_long_outlined));
    await t.pumpAndSettle();
    expect(find.text('HISTORY'), findsWidgets);
  });

  testWidgets('history search narrows results', (t) async {
    await t.pumpWidget(const ProviderScope(child: EquinoxRoot()));
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
    await t.pumpWidget(const ProviderScope(child: EquinoxRoot()));
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
    await t.pumpWidget(const ProviderScope(child: EquinoxRoot()));
    await t.tap(find.text('GET STARTED'));
    await t.pumpAndSettle();
    await t.tap(find.byIcon(Icons.receipt_long_outlined));
    await t.pumpAndSettle();
    await t.tap(find.text('Shree Krishna Cafe').first); // newest = t01
    await t.pumpAndSettle();
    expect(find.text('UPI ID'), findsOneWidget);
    expect(find.text('shreekrishna@upi'), findsOneWidget);
  });
}
