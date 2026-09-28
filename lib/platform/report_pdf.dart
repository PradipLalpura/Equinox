import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../domain/models.dart';
import '../domain/reports/report.dart';
import '../../application/providers.dart' show monthLabel;

// On-device PDF (§34). Pure Dart, zero network, zero assets.
// ponytail: amounts use "Rs" not "₹" — the PDF standard fonts are WinAnsi
// and have no rupee glyph; embedding a TTF just for one glyph is bloat.
// Upgrade path: bundle NotoSans if localized PDFs are ever required.
String _rs(num v) =>
    'Rs ${NumberFormat.decimalPattern('en_IN').format(v)}';
String _pct(double v) => '${(v * 100).toStringAsFixed(1)}%';
String _delta(double cur, double prev) {
  final d = cur - prev;
  if (d == 0) return 'same';
  return '${d > 0 ? '+' : '-'}${_rs(d.abs())}';
}

Future<Uint8List> buildMonthlyPdf(MonthlyReport r, DateTime generatedAt) async {
  final doc = pw.Document();
  final ink = PdfColors.black;
  final grey = PdfColor.fromHex('#70727A');
  final indigo = PdfColor.fromHex('#5B5CE2');
  final green = PdfColor.fromHex('#20B26B');
  final label = monthLabel(DateTime(r.year, r.month));

  pw.Widget h1(String t) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 14, bottom: 6),
        child: pw.Text(t,
            style: pw.TextStyle(
                fontSize: 15, fontWeight: pw.FontWeight.bold, color: ink)),
      );
  pw.Widget bar(double frac, PdfColor color, {double width = 220}) =>
      pw.Container(
          width: (frac.clamp(0.0, 1.0)) * width,
          height: 10,
          decoration: pw.BoxDecoration(
              color: color, borderRadius: pw.BorderRadius.circular(3)));
  pw.Table table(List<String> headers, List<List<String>> rows) =>
      pw.TableHelper.fromTextArray(
        headers: headers,
        data: rows,
        headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold, color: PdfColors.white),
        headerDecoration: pw.BoxDecoration(color: indigo),
        cellStyle: const pw.TextStyle(fontSize: 10),
        headerAlignment: pw.Alignment.centerLeft,
      );

  final maxW = r.weeks.fold<double>(0, (a, b) => a > b ? a : b);
  final maxD = r.daily.fold<double>(0, (a, b) => a > b ? a : b);

  doc.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: const pw.EdgeInsets.all(36),
    header: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('EQUINOX',
              style: pw.TextStyle(
                  fontSize: 13,
                  fontWeight: pw.FontWeight.bold,
                  color: indigo)),
          pw.Text('MONTHLY EXPENSE REPORT',
              style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: ink)),
          pw.Text(label.toUpperCase(),
              style: pw.TextStyle(fontSize: 14, color: grey)),
          pw.Divider(color: indigo),
        ]),
    footer: (ctx) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Generated on-device · Equinox keeps data on your phone',
              style: pw.TextStyle(fontSize: 9, color: grey)),
          pw.Text('Page ${ctx.pageNumber} / ${ctx.pagesCount}',
              style: pw.TextStyle(fontSize: 9, color: grey)),
        ]),
    build: (ctx) => [
      h1('Summary'),
      table(
          ['Metric', 'This month'],
          [
            ['Total spending', _rs(r.total)],
            ['Total savings', _rs(r.saved)],
            ['Transactions', '${r.count}'],
            ['Average transaction', _rs(r.avg)],
            [
              'Largest',
              r.largest == null
                  ? '—'
                  : '${_rs(r.largest!.amount)} · ${r.largest!.merchant}'
            ],
          ]),
      h1('Category breakdown'),
      table(
          ['Category', 'Amount', 'Share', 'Txns'],
          [
            for (final c in r.categories)
              [
                c.category.label,
                _rs(c.total),
                _pct(c.pct),
                '${c.count}'
              ],
          ]),
      h1('Weekly spending'),
      for (var i = 0; i < 5; i++)
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 3),
          child: pw.Row(children: [
            pw.SizedBox(
                width: 60, child: pw.Text('Week ${i + 1}')),
            bar(maxW <= 0 ? 0 : r.weeks[i] / maxW, indigo),
            pw.SizedBox(width: 8),
            pw.Text(_rs(r.weeks[i])),
          ]),
        ),
      h1('Daily spending'),
      pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            for (final v in r.daily)
              pw.Container(
                width: 5,
                height: maxD <= 0 ? 2 : 2 + 38 * (v / maxD),
                margin: const pw.EdgeInsets.only(right: 1.5),
                color: v > 0 ? indigo : PdfColor.fromHex('#E4E5F2'),
              ),
          ]),
      pw.Text('Day 1 to ${r.daily.length}',
          style: pw.TextStyle(fontSize: 9, color: grey)),
      h1('Largest expenses'),
      if (r.largestN.isEmpty) pw.Text('No spending this month.'),
      table(
          ['Merchant', 'Amount', 'Category'],
          [
            for (final t in r.largestN)
              [t.merchant, _rs(t.amount), t.category.label],
          ]),
      h1('Top merchants'),
      if (r.merchants.isEmpty) pw.Text('No merchant activity.'),
      table(
          ['Merchant', 'Transactions', 'Total'],
          [
            for (final m in r.merchants)
              [m.merchant, '${m.count}', _rs(m.total)],
          ]),
      h1('Savings'),
      table(
          ['Target', 'Saved', 'Progress', 'Remaining'],
          [
            [
              _rs(r.target),
              _rs(r.saved),
              _pct(r.target <= 0 ? 0 : r.saved / r.target),
              _rs((r.target - r.saved).clamp(0, double.infinity)),
            ],
          ]),
      h1('Month comparison'),
      table(
          ['Metric', 'This month', 'Previous', 'Change'],
          [
            [
              'Spending',
              _rs(r.total),
              _rs(r.prevTotal),
              _delta(r.total, r.prevTotal)
            ],
            [
              'Savings',
              _rs(r.saved),
              _rs(r.prevSaved),
              _delta(r.saved, r.prevSaved)
            ],
            [
              'Transactions',
              '${r.count}',
              '${r.prevCount}',
              '${r.count - r.prevCount >= 0 ? '+' : ''}${r.count - r.prevCount}'
            ],
          ]),
      pw.SizedBox(height: 12),
      pw.Text(
          'Generated ${generatedAt.day} ${monthLabel(generatedAt).split(' ').first} ${generatedAt.year} · Confirmed spending only (successful payments).',
          style: pw.TextStyle(fontSize: 9, color: grey)),
      pw.Text('Savings are explicit contributions recorded in Equinox.',
          style: pw.TextStyle(fontSize: 9, color: green)),
    ],
  ));
  return doc.save();
}
