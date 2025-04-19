import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

class StepCounter extends StateNotifier<int> {
  StepCounter() : super(0) {
    inisStepCounter();
  }

void inisStepCounter() {
Pedometer.stepCountStream.listen((event) {
state = event.steps;}, onError: (error){
print('Step Counter Error: $error');

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