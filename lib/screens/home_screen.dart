import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../widgets/hexagon_status.dart';
import '../widgets/water_tracker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoyceDataService>(context);
    final nextPeriod = data.getNextPeriodDate();
    
    String status = "Ready to start";
    String daysLeft = "";
    
    if (nextPeriod != null) {
      int diff = nextPeriod.difference(DateTime.now()).inDays;
      if (diff > 0) {
        status = "Period in";
        daysLeft = "$diff Days";
      } else if (diff == 0) {
        status = "Period";
        daysLeft = "Starts Today";
      } else {
        status = "Period";
        daysLeft = "Ongoing";
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Hexagon Status
              Center(
                child: HexagonStatus(
                  status: status,
                  subStatus: daysLeft,
                ),
              ),
              const SizedBox(height: 40),
              
              // Action Button
              ElevatedButton(
                onPressed: () => data.logPeriodStart(DateTime.now()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Period Starts', style: TextStyle(fontSize: 18)),
              ),
              
              const SizedBox(height: 40),
              
              // Water Tracker
              const WaterTracker(),
              
              const SizedBox(height: 40),
              
              // Tips for You (Premium Card)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB6C1), Color(0xFFFFDAB9)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.white, size: 30),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Tip',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Stay hydrated and get 8 hours of sleep today.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
