import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/data_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataService = LoyceDataService();
  await dataService.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => dataService,
      child: const LoyceApp(),
    ),
  );
}

class LoyceApp extends StatelessWidget {
  const LoyceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loyce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB6C1),
          primary: const Color(0xFFFF6B6B),
          secondary: const Color(0xFF4ECDC4),
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
