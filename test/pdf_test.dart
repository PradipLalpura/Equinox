import 'package:equinox/domain/models.dart';
import 'package:equinox/domain/reports/report.dart';
import 'package:equinox/platform/report_pdf.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PDF generates offline, non-trivial bytes', () async {
    final r = buildReport(seedTx, seedSavings, 5000, 2026, 9);
    final bytes = await buildMonthlyPdf(r, DateTime(2026, 10, 1, 9));
    expect(bytes.lengthInBytes, greaterThan(5000));
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
  });

  test('PDF handles an empty month without crashing', () async {
    final r = buildReport(const [], const [], 5000, 2020, 2);
    final bytes = await buildMonthlyPdf(r, DateTime(2020, 3, 1));
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
  });
}
