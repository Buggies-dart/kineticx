import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounter extends StateNotifier<int> {
  StepCounter() : super(0) {
    _initStepCounter();
  }

  int _initialSteps = 0;
  String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void _initStepCounter() async {
final prefs = await SharedPreferences.getInstance();
_initialSteps = prefs.getInt('initialSteps') ?? 0;
_currentDate = prefs.getString('stepDate') ?? _currentDate;

Pedometer.stepCountStream.listen((event) async {
final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

if (today != _currentDate) {
        // It's a new day — save yesterday's count to history
int yesterdaySteps = (event.steps - _initialSteps).clamp(0, event.steps);

List<String> history = prefs.getStringList('stepHistory') ?? [];
history.add('$today:$yesterdaySteps');
await prefs.setStringList('stepHistory', history);

        // Reset for new day
_initialSteps = event.steps;
_currentDate = today;
await prefs.setInt('initialSteps', _initialSteps);
await prefs.setString('stepDate', _currentDate);

state = 0; // Reset today's count
      } else {
        state = (event.steps - _initialSteps).clamp(0, event.steps);
      }
    }, onError: (err) {
      print("Step Counter Error: $err");
    });
  }
}


// Total Steps Provider
class FinalStepCounter extends ChangeNotifier{
int totalSteps = 10000;
void setTotalSteps(int steps){
totalSteps = steps;
notifyListeners();
}

}

// Duration Provider

class StepSession {
  final DateTime? startTime;

  StepSession({this.startTime});

  StepSession copyWith({DateTime? startTime}) {
    return StepSession(startTime: startTime ?? this.startTime);
  }
}

class StepSessionNotifier extends StateNotifier<StepSession> {
  StepSessionNotifier() : super(StepSession());

  void startSession() {
if (state.startTime == null) {
state = state.copyWith(startTime: DateTime.now());
    }
  }

  void resetSession() {
state = StepSession();
  }

  Duration? get duration {
    if (state.startTime == null) return null;
    return DateTime.now().difference(state.startTime!);
  }
}