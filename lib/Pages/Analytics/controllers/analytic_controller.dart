import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Models/daily_health_data.dart';


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