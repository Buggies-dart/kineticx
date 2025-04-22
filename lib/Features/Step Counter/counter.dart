import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/main.dart';
import 'package:permission_handler/permission_handler.dart';


class Stepcounter extends ConsumerStatefulWidget {
  const Stepcounter({super.key});

  @override
  ConsumerState<Stepcounter> createState() => _StepcounterState();
}

class _StepcounterState extends ConsumerState<Stepcounter> {

Future<void> requestPermission() async {
  PermissionStatus status = await Permission.activityRecognition.request();
  if (status.isGranted) {
    print("Permission Granted");
  } else {
    print("Permission Denied");
  }
}
@override
  void initState() {
super.initState();
  requestPermission();
  }

  DateTime? startTime;
  @override
  Widget build(BuildContext context) {
// Theme
final theme = Theme.of(context);

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

// Step Counts Provider
final stepCounts = ref.watch(stepCountProvider);
final maxStepCounts = ref.watch(maxStepsProvider).totalSteps;
final sessionNotifier = ref.read(stepSessionProvider.notifier);

// Metrics Calculation
final caloriesBurned = stepCounts * 0.04;
final distance = stepCounts * 0.0008;
final durationInMinutes = sessionNotifier.duration?.inMinutes == 0 ? 0 : sessionNotifier.duration?.inMinutes;
final speed = distance / (durationInMinutes! / 60);

return Scaffold(
body: SafeArea( 
  child: Center(
child: Column(
    children: [
SizedBox(height: sizeHeight * 0.05),
Text('Today', style: Theme.of(context).textTheme.headlineMedium),

SizedBox(height: sizeHeight / 20),

Stack(
  
children: [ 
SizedBox( width: sizeWidth/1.7,  height: sizeHeight/3.5,
child: CircularProgressIndicator(
value: stepCounts / maxStepCounts,
valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
strokeWidth: 5, backgroundColor: Colors.black.withValues(alpha: 0.1),
),
),
Positioned( right: 20, left: 25, top: 50, bottom: 50,
  child: Image.asset(Images.footSteps, color: theme.primaryColorDark.withValues(alpha: 0.8),),
),
    ]),
   
SizedBox(height: sizeHeight * 0.02),
Text('$stepCounts', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: theme.primaryColorDark.withValues(alpha: 0.8))),
SizedBox(height: sizeHeight * 0.01),
Text('Steps Today', style: theme.textTheme.titleMedium!.copyWith(color: Colors.black.withValues(alpha: 0.5))),

SizedBox(height: sizeHeight * 0.05),

SizedBox( height: 150, width: sizeWidth,
child: Padding(
  padding: const EdgeInsets.all(10),
  child: Row(children: [
  figures(context, sizeHeight, stepCounts, 'Calories', caloriesBurned.toStringAsFixed(1), 'Kcal'),
  VerticalDivider(
  color: textColorBlack.withValues(alpha: 0.5), indent: 20,
  endIndent: 60, thickness: 2, width: sizeWidth * 0.15,),
  
  figures(context, sizeHeight, stepCounts, 'Distance', distance.toStringAsFixed(1), 'Km'),
  
  VerticalDivider(
  color: textColorBlack.withValues(alpha: 0.5), indent: 20,
  endIndent: 60, thickness: 2, width: sizeWidth * 0.15,),
  
  figures(context, sizeHeight, stepCounts, 'Speed Avg', speed.toStringAsFixed(1), 'Km/h'),
  ],
),
),
),
SizedBox(height: sizeHeight * 0.05),
  Text('You have taken 10,392 steps this week', style: theme.textTheme.titleMedium,)
],
),
  ),
),
);
}

Column figures(BuildContext context, double sizeHeight, int stepCounts, String text, String value, String unit) {
return Column(
children: [
Text(text, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black.withValues(alpha: 0.5))),
SizedBox(height: sizeHeight * 0.01),
Text(value, style: Theme.of(context).textTheme.titleMedium),
SizedBox(height: sizeHeight * 0.01),
Text(unit, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black.withValues(alpha: 0.5))),
  ],
);
  }
}