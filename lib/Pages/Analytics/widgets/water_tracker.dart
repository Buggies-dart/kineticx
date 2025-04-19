import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/main.dart';
import 'package:water_animation/water_animation.dart';

class WaterTracker extends ConsumerStatefulWidget {
  const WaterTracker({super.key});

  @override
  ConsumerState<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends ConsumerState<WaterTracker> {

  @override
  Widget build(BuildContext context) {
final cupsOfWaterDataRef = ref.watch(analyticsProvider).cupsOfWater;
final theme = Theme.of(context);
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;


return Column( mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Stack(
  alignment: Alignment.center,
  children: [
  
  WaterAnimation(
  width: sizeWidth/2.5,
  height: sizeHeight/11,
  waterFillFraction: cupsOfWaterDataRef.toDouble() / 1000,
  fillTransitionDuration: Duration(seconds: 1),
  fillTransitionCurve: Curves.easeInOut,
  amplitude: 5,
  frequency: 0.5,
  speed: 1,
  waterColor: Color(0xFF95CCE3),
  gradientColors: [Color(0xFF95CCE3), Colors.lightBlueAccent],
  enableRipple: true,
  enableShader: false,
  realisticWave: true,
  decoration: BoxDecoration(
  color: whiteColor,
  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
  ),
   ),
  
  Text(' ${(cupsOfWaterDataRef / 125).toInt()}/8 Cups', style: theme.textTheme.bodySmall!.copyWith( fontWeight: FontWeight.bold))
  
  ]
  )
  ],
  );
    
  }
}

