import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCurrentMetricsToHistory(SharedPreferences prefs) async {
  // Read the current metrics
  final currentCups = prefs.getInt('cupsOfWater') ?? 0;
  final currentCalories = prefs.getInt('caloriesBurned') ?? 0;
  final heartRatesString = prefs.getStringList('heartRateData') ?? [];
  final heartRates = heartRatesString.map((e) => int.parse(e)).toList();
  final currentBpm = prefs.getInt('bpm') ?? 0;

  // Create a string or JSON representing this day's data
  final historyEntry = {
    'date': DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))),
    'cupsOfWater': currentCups,
    'caloriesBurned': currentCalories,
    'heartRateData': heartRates,
    'bpm': currentBpm,
  };

 // Load previous history
List<String> history = prefs.getStringList('metricsHistory') ?? [];

  // Add new day to history
history.add(historyEntry.toString()); 

  // Save updated history
await prefs.setStringList('metricsHistory', history);
}  