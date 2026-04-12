import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/period.dart';

class LoyceDataService extends ChangeNotifier {
  static const String periodBoxName = 'periods';
  static const String settingsBoxName = 'settings';
  static const String waterBoxName = 'water';

  // Default Settings
  int averageCycleLength = 28;
  int averagePeriodLength = 5;
  int lutealPhaseLength = 14;

  List<Period> periods = [];
  Map<String, int> dailyWater = {}; // key: yyyy-MM-dd

  Future<void> init() async {
    await Hive.initFlutter();
    
    final pBox = await Hive.openBox<dynamic>(periodBoxName);
    final sBox = await Hive.openBox<dynamic>(settingsBoxName);
    await Hive.openBox<int>(waterBoxName);

    // Load settings
    averageCycleLength = sBox.get('cycleLength', defaultValue: 28);
    averagePeriodLength = sBox.get('periodLength', defaultValue: 5);
    lutealPhaseLength = sBox.get('lutealPhase', defaultValue: 14);

    // Load periods (stored as Maps)
    periods = pBox.values.map((item) {
      if (item is Map) {
        return Period(
          startDate: DateTime.parse(item['startDate']),
          endDate: item['endDate'] != null ? DateTime.parse(item['endDate']) : null,
          duration: item['duration'],
        );
      }
      return item as Period; // Fallback
    }).toList();
    
    periods.sort((a, b) => b.startDate.compareTo(a.startDate));

    notifyListeners();
  }

  // Adding a period
  void logPeriodStart(DateTime date) {
    String key = date.toIso8601String();
    Hive.box<dynamic>(periodBoxName).put(key, {
      'startDate': date.toIso8601String(),
      'endDate': null,
      'duration': averagePeriodLength,
    });
    
    periods.insert(0, Period(startDate: date, duration: averagePeriodLength));
    notifyListeners();
  }

  // Water Logic
  int getWaterForDate(DateTime date) {
    String key = "${date.year}-${date.month}-${date.day}";
    return Hive.box<int>(waterBoxName).get(key, defaultValue: 0) ?? 0;
  }

  void addWater(DateTime date, int amount) {
    String key = "${date.year}-${date.month}-${date.day}";
    int current = getWaterForDate(date);
    Hive.box<int>(waterBoxName).put(key, current + amount);
    notifyListeners();
  }

  // Prediction Engine
  DateTime? getNextPeriodDate() {
    if (periods.isEmpty) return null;
    return periods.first.startDate.add(Duration(days: averageCycleLength));
  }

  DateTime? getOvulationDate() {
    DateTime? next = getNextPeriodDate();
    if (next == null) return null;
    return next.subtract(Duration(days: lutealPhaseLength));
  }
}
