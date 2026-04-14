import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoyceDataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reports', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFDF7FF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFDF7FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Summary Cards (Premium HSL style)
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    '5 Days',
                    'Average period',
                    const Color(0xFFFFB6C1),
                    Icons.opacity,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    '${data.averageCycleLength} Days',
                    'Average cycle',
                    const Color(0xFFFFDAB9),
                    Icons.loop,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Category Grid (Simplified for now)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildCategoryItem(context, Icons.favorite, 'Sex'),
                _buildCategoryItem(context, Icons.monitor_weight_outlined, 'Weight'),
                _buildCategoryItem(context, Icons.thermostat, 'Temp'),
                _buildCategoryItem(context, Icons.nightlight_round, 'Sleep'),
                _buildCategoryItem(context, Icons.water_drop, 'Water'),
                _buildCategoryItem(context, Icons.settings_accessibility, 'Self-exam'),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Customize & Export buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.tune),
                    label: const Text('Customize'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.ios_share),
                    label: const Text('Export'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
