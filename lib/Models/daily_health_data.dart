
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAnalytics{
final int cupsOfWater;
final int caloriesBurned;
final List<int> heartRateData;
final List<int> sleepData;
final int bpm;

UserAnalytics({required this.cupsOfWater, required this.caloriesBurned, required this.heartRateData, required this.sleepData, required this.bpm});

UserAnalytics copyWith({int? cupsOfWater, int? caloriesBurned, List<int>? heartRateData, List<int>? sleepData, int? bpm}){
return UserAnalytics(cupsOfWater: cupsOfWater ?? this.cupsOfWater, caloriesBurned: caloriesBurned ?? this.caloriesBurned, heartRateData: heartRateData ?? this.heartRateData, sleepData: sleepData?? this.sleepData, bpm: bpm?? this.bpm);
}
}
