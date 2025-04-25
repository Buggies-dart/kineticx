import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kineticx/Models/daily_health_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AnalyticController extends StateNotifier<UserAnalytics>{
AnalyticController() : super(UserAnalytics(cupsOfWater: 0, caloriesBurned: 0, heartRateData: [], sleepData: [], bpm: 0));


void cupsDrank() async{
state = state.copyWith(cupsOfWater: state.cupsOfWater + 125);

final prefs = await SharedPreferences.getInstance();
 prefs.setInt('currentCupsOfWater', state.cupsOfWater);

}

void caloriesBurned(int caloriesTracker) async{
state = state.copyWith(caloriesBurned: caloriesTracker);

final prefs = await SharedPreferences.getInstance();
 prefs.setInt('currentCaloriesBurned', state.caloriesBurned);
}

void heartRateData(List<int> heartRates) async{
state = state.copyWith(heartRateData: heartRates );

final prefs = await SharedPreferences.getInstance();
List<String> heartRateStrings = heartRates.map((e) => e.toString()).toList();
prefs.setStringList('currentHeartRateData', heartRateStrings);
}

void sleepData(List<int> sleepTracker) async{
state = state.copyWith(sleepData: sleepTracker );

final prefs = await SharedPreferences.getInstance();
List<String> sleepTrackerStrings = sleepTracker.map((e) => e.toString()).toList();

prefs.setStringList('currentSleepData', sleepTrackerStrings);
}

void bpmData(int bpm) async{
state = state.copyWith(bpm: bpm);

final prefs = await SharedPreferences.getInstance();
prefs.setInt('currentBpm', state.bpm);
}

}

void checkAndResetDailyMetrics(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final lastSavedDate = prefs.getString('lastUpdatedDate');

  if (lastSavedDate != today) {
    // Convert saved step data to List<int>
    final stringStepList = prefs.getStringList('currentHeartRateData') ?? [];
    final stepList = stringStepList.map((e) => int.tryParse(e) ?? 0).toList();

    
    UserAnalytics userAnalytics = UserAnalytics(
      cupsOfWater: prefs.getInt('currentCupsOfWater') ?? 0,
      caloriesBurned: prefs.getInt('currentCaloriesBurned') ?? 0,
      heartRateData: stepList,
      sleepData: [],
      bpm: prefs.getInt('currentBpm') ?? 0,
    );

    // Optionally: Save userAnalytics data somewhere or process it

    // Reset today's metrics
    await prefs.setInt('currentCupsOfWater', 0);
    await prefs.setInt('currentCaloriesBurned', 0);
    await prefs.setStringList('currentSteps', []);
    await prefs.setInt('currentBpm', 0);
    await prefs.setString('lastUpdatedDate', today);
  }
}
