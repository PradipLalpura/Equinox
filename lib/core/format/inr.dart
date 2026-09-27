import 'package:intl/intl.dart';

// Indian currency formatting (§40): ₹1,250 · ₹18,420 · ₹1,24,500
final _inr = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

String inr(num v) => _inr.format(v);
String inr2(num v) =>
    NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2).format(v);
String pct(double v) => '${(v * 100).toStringAsFixed(1)}%';
