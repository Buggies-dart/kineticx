import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Pages/Analytics/widgets/calendar.dart';
import 'package:kineticx/Pages/Analytics/widgets/heart_rate_equalizer.dart';
import 'package:kineticx/Pages/Analytics/widgets/sleep_data.dart';
import 'package:kineticx/Pages/Analytics/widgets/water_tracker.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/main.dart';
import 'package:table_calendar/table_calendar.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
 List<double> sleepData = [2, 5, 3, 8, 6, 4, 7, 9, 3, 5, 8];
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<String>> events = {};
final currentDate = DateTime.now();
Timer? timer;
@override
  void initState() {
super.initState();
selectedDay = DateTime.now();
focusedDay = DateTime.now();
timer = Timer.periodic(Duration(seconds: 1), (timer) {
setState(() {
selectedDay = DateTime.now();
focusedDay = DateTime.now();
});
});
}

 @override
void dispose() {
timer?.cancel(); 
  super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
bool isToday = selectedDay.year == currentDate.year &&
selectedDay.month == currentDate.month && selectedDay.day == currentDate.day;
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return  Scaffold(
body: SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Calendar(selectedDay: selectedDay, focusedDay: focusedDay,),
    SizedBox(height: sizeHeight/25),
    isToday? Text("Today's Report", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) :
    Text(
    "Your progress on ${selectedDay.toLocal()}",
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),

Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container( height: sizeHeight/12, width: double.infinity, decoration: BoxDecoration( border: Border.all(width: 0.5, color: theme.colorScheme.onPrimaryContainer),
  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)), color: theme.colorScheme.surfaceContainer),
  child: Column(
  children: [
  Text('Active Calories', style: theme.textTheme.titleMedium),
  SizedBox(height: 5),
  Text('645 kCal', style: theme.textTheme.headlineMedium,)
  ],
),
),
),
SizedBox(height: sizeHeight/40),
   
Row(
  children: [
    Container( width: sizeWidth/2, height: sizeHeight/4.5,
    decoration: BoxDecoration(
    color: Color(0xFFFFEBEB), borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
    ),
    child: Column(
    children: [
    activityTitle(theme, Images.heartRate, 'Heart Rate'),
    SizedBox(height: 5),
    Padding(
    padding: const EdgeInsets.all(12),
    child: Container( decoration: BoxDecoration(color: theme.colorScheme.surfaceContainer,  borderRadius: BorderRadius.circular(10)),
    height: sizeHeight/7.5, width: sizeWidth/2.4,
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
    children: [
HeartRateEqualizer(),
Consumer( builder: (context, ref, child) =>  Text('                       ${ref.watch(analyticsProvider).bpm} Bpm', style: theme.textTheme.labelMedium!.copyWith(color: Colors.black)))
],
),
)),
)
],
),),
SizedBox(width: 10),
Column(
children: [
Container( height: sizeHeight/7, width: sizeWidth/2.5, decoration: BoxDecoration( color: Color(0xFFFFE8C6),
borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
),
child: Column(children: [
activityTitle(theme, Images.steps, 'Steps'),
SizedBox(height: 15),

Consumer( builder: (context, ref, child) {
final stepCount = ref.watch(stepCountProvider);
final maxSteps = ref.watch(maxStepsProvider).totalSteps;  
return Column(
  children: [
Text('$stepCount/$maxSteps', style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),

SizedBox(height: 15),

Padding(
  padding: const EdgeInsets.only(left: 10, right: 10),
  child: LinearProgressIndicator(
  value: stepCount / maxSteps, minHeight: 10,
  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
   backgroundColor: progressBackgroundColor, borderRadius: BorderRadius.circular(10),
  ),
),
  ],
);
}),



],
),
),

Padding(
padding: const EdgeInsets.only(top: 12),
child: Container( width: sizeWidth/2.5, height: sizeHeight/16,
decoration: BoxDecoration( color: Color(0xFFF6CFCF), borderRadius: BorderRadius.circular(10)),
 child: Center(child: Text('Keep it up! 💪', style: theme.textTheme.headlineMedium,)),  ),
) 
  
],
),
  ],
),
SizedBox(height: 20),

Row(
  children: [
Padding(
padding: const EdgeInsets.only(top: 12),
child: Container( width: sizeWidth/2.3, height: sizeHeight/6,
decoration: BoxDecoration( color: Color(0xFFEFE2FF), borderRadius: BorderRadius.circular(10)),
child: Center(child: Column(
children: [
activityTitle(theme, Images.sleep, 'Sleep'),
SizedBox( height: sizeHeight/30),
SleepData(sleepData: sleepData)
],
)
),),
),

SizedBox(width: sizeWidth/20),

Padding(
padding: const EdgeInsets.only(top: 12), 
child: Container( width: sizeWidth/2.3, height: sizeHeight/6,
decoration: BoxDecoration( color: Color(0xFFD8E6EC), borderRadius: BorderRadius.circular(10)),
child: Center(
child: Column(
children: [
activityTitle(theme, Images.waterDrop, 'Water'),
SizedBox( height: sizeHeight/70),

Stack(
  children: [ WaterTracker( boxDecoration: BoxDecoration( color: whiteColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
    ),
  sizeWidth: sizeWidth/2.5, sizeHeight: sizeHeight/11,
  ),
 Positioned(  left: 45, top: 30,
child: Consumer( builder: (context, ref, child) {
final cupsOfWaterDataRef = ref.watch(analyticsProvider).cupsOfWater;
return Text(' ${(cupsOfWaterDataRef / 125).toInt()}/8 Cups', style: theme.textTheme.bodySmall!.copyWith( fontWeight: FontWeight.bold));
    }),
 )
])
],
),
),
),
)
],
) 
  
],
),
),
),
);
}



  Widget activityTitle(ThemeData theme, String image, String text) {
    return Padding(
    padding: const EdgeInsets.only(top: 10, left: 10),
    child: Row( 
    children: [
    Image.asset(image, height: 30, width: 30),
    SizedBox(width: 10),
    Text(text, style: theme.textTheme.titleMedium),
    ]
    ),
  );
  }
}
const progressColor = Color(0xFFFCC46F);
const progressBackgroundColor = Color.fromARGB(255, 240, 239, 239);