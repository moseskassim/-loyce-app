import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'calendar_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'dart:ui';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const ReportsScreen(),
    const Center(child: Text('Reminders')), 
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Global App Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/loyce_bg.jpg',
              fit: BoxFit.cover,
              color: Colors.white.withValues(alpha: 0.1), // Subtle visibility
              colorBlendMode: BlendMode.lighten,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFFFDF7FF)),
            ),
          ),
          // Content
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'Reminders'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_outlined), label: 'More'),
        ],
      ),
    );
  }
}
