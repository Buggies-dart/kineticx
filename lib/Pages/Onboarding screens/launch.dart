import 'package:flutter/material.dart';
import 'package:kineticx/Pages/Onboarding%20screens/onboarding1.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return Scaffold(
backgroundColor: whiteColor,
body: Column( 
children: [
Stack(
children: [ Container( height: sizeHeight/1.5, width: sizeWidth/1,
decoration: BoxDecoration( image: DecorationImage(image: AssetImage(Images.getStarted), fit: BoxFit.cover ),
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
Text('Wherever You Are', style: theme.textTheme.displayLarge ),

SizedBox(height: 5),

Stack(
children: [ Padding(
padding:  EdgeInsets.only(top: sizeHeight/80),
child: Container( width: sizeWidth/5, height: sizeHeight/45,
color: theme.primaryColor,),
),
Text('Health is Number One', style: theme.textTheme.displayLarge),
]
),
],
),
SizedBox( height: sizeHeight/30,),

Text('There is no instant way to a healthy life', style: theme.textTheme.bodyMedium),

SizedBox( height: sizeHeight/30,),

progressBarOnboarding(sizeHeight, sizeWidth, theme, 1),

SizedBox( height: sizeHeight/30,),

elevatedButton(sizeWidth, sizeHeight, (){
 Navigator.push(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => OnboardingOne(),
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));

}, 'Get Started')
 ],
),
);
}



}