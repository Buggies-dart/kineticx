import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Pages/Onboarding%20screens/Assessments/controllers/assesments.dart';
import 'package:kineticx/Pages/Onboarding%20screens/launch.dart';
import 'package:kineticx/components.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Kineticx Fitness',
theme: Pallete.lightTheme,
themeMode: ThemeMode.light,
home: WelcomeScreen()
);
  }
}

