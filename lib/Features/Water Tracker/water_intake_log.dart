import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/Widgets/widgets.dart' show showProgressSnackBar;
import 'package:kineticx/main.dart';
import 'package:water_animation/water_animation.dart';

class WaterIntakeLog extends ConsumerStatefulWidget {
  const WaterIntakeLog({super.key});

  @override
  ConsumerState<WaterIntakeLog> createState() => _WaterIntakeLogState();
}

class _WaterIntakeLogState extends ConsumerState<WaterIntakeLog> {

bool isWaterIntakeComplete(double intake){
return intake == 8;
}

bool showWaterGoalDialog = false;
  @override
  Widget build(BuildContext context) {

// Controllers
final cupsOfWaterDataRef = ref.watch(analyticsProvider).cupsOfWater;

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

// Water Percentage
final waterPercentage = (cupsOfWaterDataRef / 1000).toDouble() * 100;

// Cups Taken
final cupsTaken = cupsOfWaterDataRef / 125;


return  Scaffold(
appBar: AppBar(leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close, size: 30)),
backgroundColor: scaffold,
),
body: Stack(
  children: [ Column( crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  SizedBox(height: 20),
  Center(
    child: Text.rich(
    TextSpan( children: [
    TextSpan( text: 'Today\'s goal:',style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
    TextSpan( text: ' ${(cupsTaken).toInt()}/8 Cups', style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30, fontWeight: FontWeight.bold)),
    ]),
    ),
  ),
  SizedBox(height: sizeHeight/7,),
  
  Stack(
    children: [ CustomPaint( painter: WaterDropPainter(), 
  child: ClipPath( clipper: WaterDropClipper(),
  child: WaterAnimation(
  onTap: () { if (cupsTaken == 8) {
  showProgressSnackBar(context, '🎉 Congratulations! You\'ve reached your water goal!');
  }
   else{
  ref.read(analyticsProvider.notifier).cupsDrank(); 
  
   }  
  },
  enableSecondWave: false,
  secondWaveColor: Colors.purpleAccent,
  secondWaveAmplitude: 6,
  secondWaveFrequency: 2,
  width: sizeWidth/1.1,
  height: sizeHeight/2.5,
  waterFillFraction: cupsOfWaterDataRef.toDouble() / 1000,
  fillTransitionDuration: Duration(seconds: 1),
  fillTransitionCurve: Curves.easeInSine,
  amplitude: 5,
  frequency: 2,
  speed: 2,
  waterColor: Color(0xFF95CCE3),
  enableRipple: true,
  realisticWave: true,
  decoration: BoxDecoration(
  color: whiteColor,
  ),
  ),
),
    ),
    Positioned( top: sizeHeight/5, left: sizeWidth/2.6,
    child: Text('${waterPercentage.toStringAsFixed(0)}%', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 25),))
  ]),
  cupsTaken == 8 ?
Padding(
    padding: const EdgeInsets.all(20),
    child: Text('You did it Champ! go again tomorrow!💧', style: Theme.of(context).textTheme.titleMedium),
  )
 : Padding(
    padding: const EdgeInsets.all(20),
    child: Text('Take a cup of water and tap the drop to add it to your log', style: Theme.of(context).textTheme.titleMedium),
  ),
  ],
    ),
 isWaterIntakeComplete(cupsTaken) && !showWaterGoalDialog ?
  // Water Intake Complete Dialog
BackdropFilter( filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  child: Center(
    child: Container( width: sizeWidth, height: sizeHeight/2,
    margin: EdgeInsets.symmetric(horizontal: 24), padding: EdgeInsets.all(16), decoration: BoxDecoration(
  color: steelGray, borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.black26, blurRadius: 15, offset: Offset(2, 4),
    ),
    ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: BorderSide.strokeAlignCenter),
      child: Column( mainAxisSize: MainAxisSize.min,
      
      children: [
        Align( alignment: Alignment.topRight,
      child: TextButton(onPressed: (){
        setState(() {
        showWaterGoalDialog = true;}
        );
      },child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        child: Text('x', style: TextStyle(fontSize: 25, color: Colors.grey),),
      ))),
        
Column(
children: [
Image.asset(Images.done, width: sizeWidth/2.1, height: sizeHeight/4, fit: BoxFit.cover),
SizedBox(height: 12),
      Text(
      "Congratulations🎉!", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 30, color: whiteColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
      ),
      SizedBox(height: 8),
      Text(
      "You've reached your water intake goal for today.", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: whiteColor), textAlign: TextAlign.center,
      ),
        ],
      ),
      ],
      ),
    ),
    ),
  ),
) : Text(''),

]),
);
  }
  }


class WaterDropClipper extends CustomClipper<Path> {
   @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;

    Path path = Path();
    path.moveTo(centerX, height); 

    path.cubicTo(
      width, height * 0.95,       
      width * 0.85, height * 0.25, 
      centerX, 0,                 
    );

    path.cubicTo(
      width * 0.15, height * 0.25,
      0, height * 0.95,
      centerX, height,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaterDropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the shadow
    Paint shadowPaint = Paint()
      ..color = Colors.grey.withValues( alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Path for the shadow (slightly offset)
    Path shadowPath = Path();
    shadowPath.moveTo(size.width * 0.5, size.height * 0.1); // Top point
    shadowPath.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.4,
      size.width * 0.7,
      size.height * 0.8,
    ); // Right curve
    shadowPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.0,
      size.width * 0.3,
      size.height * 0.8,
    ); // Bottom curve
    shadowPath.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.1,
    ); // Left curve
    shadowPath.close();

    // Draw shadow
    canvas.save();
    canvas.translate(5, 5); // Offset for shadow
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();

    // Paint for the highlight
    Paint highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Path for the highlight
    Path highlightPath = Path();
    highlightPath.moveTo(size.width * 0.4, size.height * 0.2);
    highlightPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width * 0.3,
      size.height * 0.5,
    );
    highlightPath.close();

    // Draw highlight
    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}