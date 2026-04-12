import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoyceDataService>(context);
    final today = DateTime.now();
    final currentWater = data.getWaterForDate(today);
    const int goal = 64; // fl oz as in screenshot

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Drink water',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '$currentWater fl oz / $goal fl oz',
                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              bool filled = currentWater >= (index + 1) * 10;
              return GestureDetector(
                onTap: () => data.addWater(today, 10),
                child: Container(
                  width: 45,
                  height: 60,
                  decoration: BoxDecoration(
                    color: filled ? Colors.blueAccent.withOpacity(0.2) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: filled ? Colors.blueAccent : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.opacity,
                    color: filled ? Colors.blueAccent : Colors.grey[400],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
