import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Features/Heart%20Rate%20Measure/heart_rate_proto.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/main.dart';

class HeartRateDataWidget extends StatelessWidget {
  const HeartRateDataWidget({
    super.key,
  });

//Navigate to Heart Rate Monitor Screen
Future<void> delayedNavigation(BuildContext context) async {
await Future.delayed(Duration(milliseconds: 1500));
if (context.mounted) {
moveToNextScreen(context,  HeartRateMonitor());
}
}
  @override
  Widget build(BuildContext context) {

  // Theme
final theme = Theme.of(context);

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

    return Container( 
    height: sizeHeight/5.5, width: sizeWidth,
    decoration: BoxDecoration( color: theme.colorScheme.surfaceContainer, borderRadius: BorderRadius.all(Radius.elliptical(20, 20)) ),
    child: Column(
    children: [
    Row(
    children: [
    SizedBox( width: sizeWidth/1.05,
    child: ListTile( contentPadding: EdgeInsets.only(left: 20, right: 1),
    leading: Icon(Icons.monitor_heart, color: tomatoRed), title: Text('Heart Rate', style: theme.textTheme.headlineMedium!.copyWith(color: tomatoRed, fontSize: 20)),
    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios, size: 15)),),
    )
    ],
    ),
    
    
    Row(
    children: [
    Container( height: sizeHeight/10, width: sizeWidth/4.5, color: null,
    child: Image.asset(Images.bpmLogo, fit: BoxFit.fill,)),
    
    SizedBox(width: sizeWidth/10),
    
    Column(children: [
    Consumer( builder: (context, ref, child) {
final bpm = ref.watch(analyticsProvider).bpm;
return Text( bpm != 0 ?'${bpm.toString()} bpm' : 'No available data today', style: theme.textTheme.headlineMedium);
    }),
    SizedBox(height: sizeHeight/100),
    SizedBox( width: sizeWidth/2.5,
      child: ElevatedButton(onPressed: (){
delayedNavigation(context);
      },  style: ElevatedButton.styleFrom( fixedSize: Size(sizeWidth/2.5, 50), backgroundColor: theme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)))),
      child: Text('Measure', style: theme.textTheme.titleMedium, ),
      ),
    ),
    ],),
    ],)
    ],
    ),
    );
  }
}