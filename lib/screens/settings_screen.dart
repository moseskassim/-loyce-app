import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoyceDataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & More', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFDF7FF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFDF7FF),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Widget (As in screenshot)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary, size: 40),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last sync time', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text('Today, 10:30 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('BACKUP & RESTORE'),
          ),
          
          const SizedBox(height: 30),
          
          _buildSettingsHeader('Cycle Settings'),
          _buildSettingsItem(context, Icons.opacity, 'Period Length', '${data.averagePeriodLength} Days'),
          _buildSettingsItem(context, Icons.loop, 'Cycle Length', '${data.averageCycleLength} Days'),
          _buildSettingsItem(context, Icons.spa, 'Luteal phase', '${data.lutealPhaseLength} Days'),
          
          const SizedBox(height: 20),
          
          _buildSettingsHeader('App & Safety'),
          _buildSettingsItem(context, Icons.lock_outline, 'Password', 'Protect your data'),
          _buildSettingsItem(context, Icons.palette_outlined, 'Theme', 'Soft Pink'),
          _buildSettingsItem(context, Icons.info_outline, 'About Loyce', 'Version 1.0.0'),
          
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Loyce - Offline Wellbeing Tracker',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary.withOpacity(0.7)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: const TextStyle(color: Colors.grey)),
            const SizedBox(width: 5),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
