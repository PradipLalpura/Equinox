import 'package:equinox/domain/models.dart';
import 'package:equinox/domain/upi/upi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses a full UPI QR', () {
    final p = UpiPayload.parse(
        'upi://pay?pa=merchant@upi&pn=Shree%20Krishna%20Cafe&am=450&cu=INR&tr=REF123&tn=Lunch&mc=5411');
    expect(p.vpa, 'merchant@upi');
    expect(p.payeeName, 'Shree Krishna Cafe');
    expect(p.amount, 450);
    expect(p.currency, 'INR');
    expect(p.reference, 'REF123');
    expect(p.note, 'Lunch');
    expect(p.merchantCode, '5411');
  });

  test('amount is optional, currency defaults to INR', () {
    final p = UpiPayload.parse('upi://pay?pa=x@y');
    expect(p.amount, isNull);
    expect(p.currency, 'INR');
    expect(p.payeeName, isNull);
  });

  test('rejects non-UPI and malformed payloads', () {
    for (final raw in [
      'https://example.com/pay',
      'upi://pay',
      'upi://pay?pa=',
      'upi://pay?pa=novatsign',
      'upi://pay?pa=a@b&am=abc',
      'upi://pay?pa=a@b&am=0',
      'upi://pay?pa=a@b&am=-5',
      'tez://upi/pay?pa=a@b',
      '',
    ]) {
      expect(() => UpiPayload.parse(raw), throwsA(isA<UpiParseException>()),
          reason: raw);
    }
  });

  test('toUri includes only known params', () {
    final p = UpiPayload.parse('upi://pay?pa=a@b&pn=Shop&am=100&tn=Note&tr=R1&mc=12');
    final u = p.toUri();
    expect(u.scheme, 'upi');
    expect(u.queryParameters['pa'], 'a@b');
    expect(u.queryParameters['am'], '100.00');
    expect(u.queryParameters['tn'], 'Note');
    final noAmt = UpiPayload.parse('upi://pay?pa=a@b').toUri(amountOverride: 25.5);
    expect(noAmt.queryParameters['am'], '25.50');
  });

  test('status machine allows only explicit reconcile exits', () {
    expect(canTransition(PayStatus.draft, PayStatus.initiated), isTrue);
    expect(canTransition(PayStatus.draft, PayStatus.successful), isFalse);
    expect(canTransition(PayStatus.initiated, PayStatus.successful), isTrue);
    expect(canTransition(PayStatus.initiated, PayStatus.pending), isTrue);
    expect(canTransition(PayStatus.pending, PayStatus.successful), isTrue);
    expect(canTransition(PayStatus.unknown, PayStatus.cancelled), isTrue);
    for (final t in [PayStatus.successful, PayStatus.failed, PayStatus.cancelled]) {
      for (final s in PayStatus.values) {
        expect(canTransition(t, s), isFalse, reason: '${t.name}→${s.name}');
      }
    }
  });

  test('five app configs, GPay/PhonePe/Paytm packages stable', () {
    expect(upiApps.length, 5);
    expect(upiApps.map((a) => a.name),
        containsAll(['super.money', 'POP UPI', 'Google Pay', 'PhonePe', 'Paytm']));
  });
}
