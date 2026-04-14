import 'package:flutter/material.dart';
import 'dart:async';
import 'main_screen.dart'; // We'll need to separate MainScreen from main.dart or refer correctly

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/loyce_bg.jpg', 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: Colors.pink[100]),
          ),
          // Dark Overlay
          Container(color: Colors.black.withValues(alpha: 0.3)),
          // Welcome Message
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'WELCOME MY LOVE BLUE POWDER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(2, 2)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
