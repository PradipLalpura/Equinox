import 'package:geolocator/geolocator.dart';

// Single transaction fix (§20, §52). Called once per payment from the review
// screen — never continuous. Returns null on ANY failure (service off,
// denied, timeout); the flow continues with "Location unavailable".
// ponytail: no reverse-geocoding (needs network + another dep); label stays
// null and Detail shows coords-or-unavailable. Add geocoding in Phase 6.
class Fix {
  final double lat, lng, accuracy;
  final DateTime time;
  const Fix(this.lat, this.lng, this.accuracy, this.time);
}

Future<Fix?> captureFix() async {
  try {
    if (!await Geolocator.isLocationServiceEnabled()) return null;
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return null;
    }
    final p = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 10),
      ),
    );
    return Fix(p.latitude, p.longitude, p.accuracy, p.timestamp);
  } catch (_) {
    return null;
  }
}
