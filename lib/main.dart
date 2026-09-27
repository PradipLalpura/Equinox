import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: EquinoxRoot()));
}

class EquinoxRoot extends StatelessWidget {
  const EquinoxRoot({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Equinox',
        debugShowCheckedModeBanner: false,
        theme: equinoxTheme(),
        home: const EquinoxApp(),
      );
}
