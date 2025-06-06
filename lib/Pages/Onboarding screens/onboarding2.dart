import 'package:flutter/material.dart';
import 'package:kineticx/Pages/Onboarding%20screens/onboarding3.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';

class OnboardingTwo extends StatefulWidget {
  const OnboardingTwo({super.key});

  @override
  State<OnboardingTwo> createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends State<OnboardingTwo> {
  @override
Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return Scaffold(
backgroundColor: whiteColor,
body:  Column( 
children: [
Stack(
children: [ Container( height: sizeHeight/1.5, width: sizeWidth/1,
decoration: BoxDecoration( image: DecorationImage(image: AssetImage(Images.dumbbell), fit: BoxFit.cover),
)
),

Positioned( top: sizeHeight/1.75,
child: Container( decoration: BoxDecoration(gradient: LinearGradient( begin: Alignment.topCenter, end: Alignment.bottomCenter,
colors: [
Color.fromARGB(0, 255, 255, 255), whiteColor
]) ),
height: sizeHeight/10, width: sizeWidth,
),
)]
),

Column(
children: [
Text('Extensive', style: theme.textTheme.displayLarge ),
SizedBox(height: 5),
Stack(
children: [ Padding(
padding:  EdgeInsets.only(top: sizeHeight/80),
child: Container( width: sizeWidth/4, height: sizeHeight/45,
color: theme.primaryColor,),
),
Text('Workout Libraries', style: theme.textTheme.displayLarge),
]
),
],
),

SizedBox( height: sizeHeight/30),

Text('Explore ~1.5k exercies made for you!', style: theme.textTheme.bodyMedium),

SizedBox( height: sizeHeight/30),

progressBarOnboarding(sizeHeight, sizeWidth, theme, 5),

SizedBox( height: sizeHeight/30),

Padding(
padding:  EdgeInsets.only(left: sizeWidth/16, right: sizeWidth/16),
child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
actionButton(sizeHeight, sizeWidth, theme, (){

Navigator.pop(context);

}, Icons.arrow_back_sharp),
actionButton(sizeHeight, sizeWidth, theme, (){

Navigator.push(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => OnboardingThree(),
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));


  }, Icons.arrow_forward_sharp),
  
  ],
  ),
)
 ],
)
);
}


  SizedBox actionButton(double sizeHeight, double sizeWidth, ThemeData theme, VoidCallback onTap, IconData icon) {
    return SizedBox( height: sizeHeight/10, width: sizeWidth/2.4,
  child: ElevatedButton(onPressed: onTap,  style: ElevatedButton.styleFrom( backgroundColor: theme.primaryColorDark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ),
  child: Icon(icon, color: whiteColor,)),
);
  }

  
  
}