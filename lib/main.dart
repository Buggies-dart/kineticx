
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Features/Step%20Counter/controllers/counter_controller.dart';
import 'package:kineticx/Models/daily_health_data.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Features/Pages/Analytics/controllers/analytic_controller.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/Assessments/controllers/assesments.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ProviderScope(child: const MyApp()));
}


final userInfoProvider = StateNotifierProvider<SaveUserInfo, UserInfo>((ref) {
return SaveUserInfo();
});

final stepCountProvider = StateNotifierProvider<StepCounter, int>((ref) {
return StepCounter();
});

final analyticsProvider = StateNotifierProvider<AnalyticController, UserAnalytics>((ref){
return AnalyticController();
});

final maxStepsProvider = ChangeNotifierProvider<FinalStepCounter>((ref)=> FinalStepCounter());

final stepSessionProvider = StateNotifierProvider<StepSessionNotifier, StepSession>(
  (ref) => StepSessionNotifier(),
);



class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

@override
  void initState() {
super.initState();
ref.read(analyticsProvider.notifier).checkAndResetDailyMetrics(ref);
  }
  @override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Kineticx Fitness',
theme: Pallete.lightTheme,
themeMode: ThemeMode.light,
home: NavigationPage()
);
}
}


