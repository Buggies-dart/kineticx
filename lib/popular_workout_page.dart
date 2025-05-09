import 'package:flutter/material.dart';
import 'package:kineticx/Utils/components.dart';

class PopularWorkoutPage extends StatefulWidget {
  const PopularWorkoutPage({super.key});

  @override
  State<PopularWorkoutPage> createState() => _PopularWorkoutPageState();
}

class _PopularWorkoutPageState extends State<PopularWorkoutPage> {
  @override
  Widget build(BuildContext context) {

  // Get the theme from the context
  final theme = Theme.of(context);

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

return Scaffold( backgroundColor: blackColor,
body: SafeArea(
  child: Column(
  children: [
  Row(children: [
IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: whiteColor,)),
SizedBox(width: sizeWidth * 0.3),
Text("Workout", style:  theme.textTheme.titleMedium!.copyWith(color: whiteColor),),
 ],
  ),

Stack(
  children: [ Container( height: sizeHeight/4, width: sizeWidth/1.1, 
  decoration: BoxDecoration( color: containerWhite,
   borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),   ),
  ),
Positioned( top: sizeHeight/1.75,
  child: Container( decoration: BoxDecoration(gradient: LinearGradient( begin: Alignment.topCenter, end: Alignment.bottomCenter,
colors: [
  Color.fromARGB(0, 255, 255, 255), whiteColor
  ]) ),
  height: sizeHeight/10, width: sizeWidth,
  ),
)
  ]),
  ],
  ),
)
    );
  }
}