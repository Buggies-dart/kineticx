import 'package:flutter_riverpod/flutter_riverpod.dart';


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

class AnalyticController extends StateNotifier<UserAnalytics>{
AnalyticController() : super(UserAnalytics(cupsOfWater: 0, caloriesBurned: 0, heartRateData: [], sleepData: [], bpm: 0));

void cupsDrank() {
state = state.copyWith(cupsOfWater: state.cupsOfWater + 125);
}

void caloriesBurned(int caloriesTracker){
state = state.copyWith(caloriesBurned: caloriesTracker);
}

void heartRateData(List<int> heartRates){
state = state.copyWith(heartRateData: heartRates );
}
void sleepData(List<int> sleepTracker){
state = state.copyWith(sleepData: sleepTracker );
}

void bpmData(int bpm){
state = state.copyWith(bpm: bpm);
}

}