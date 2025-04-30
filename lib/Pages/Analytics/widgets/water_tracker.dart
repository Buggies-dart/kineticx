import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/main.dart';
import 'package:water_animation/water_animation.dart';

class WaterTracker extends ConsumerStatefulWidget {
  const WaterTracker({super.key, required this.boxDecoration, required this.sizeHeight, required this.sizeWidth, this.text});
final Decoration boxDecoration; final double sizeHeight; final double sizeWidth; final Widget? text;
  @override
  ConsumerState<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends ConsumerState<WaterTracker> {

  @override
  Widget build(BuildContext context) {
final cupsOfWaterDataRef = ref.watch(analyticsProvider).cupsOfWater;

return Column( mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Stack(
  alignment: Alignment.center,
  children: [
  
  WaterAnimation(
  width: widget.sizeWidth,
  height: widget.sizeHeight,
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
  decoration: widget.boxDecoration,
   ),
    
  ]
  )
  ],
  );
    
  }
}

