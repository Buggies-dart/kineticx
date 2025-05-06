import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/Assessments/set_exercise.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/main.dart';

class SetAge extends ConsumerStatefulWidget {
  const SetAge({super.key});

  @override
  ConsumerState<SetAge> createState() => _SetAgeState();
}

class _SetAgeState extends ConsumerState<SetAge> {
int selectedAge = 60;
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return  Scaffold(
body: SafeArea(
  child: Column(children: [
    Row(
  children: [
  arrowBackIcon(context),
  
  SizedBox(width: sizeWidth/30),
  
  Text('Assessment', style: theme.textTheme.displayLarge,),
  
  SizedBox(width: sizeWidth/4.5),

  Chip( backgroundColor:  chipColor, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal( left: Radius.elliptical(15, 15),
   right: Radius.elliptical(15, 15))),
  label: Text('4 of 5', style: TextStyle( fontSize: 20, color: theme.primaryColor, ),)),
  
  ],
  ),
      
SizedBox( height: sizeHeight/20),
  
Text('What is Your Age?', style: theme.textTheme.labelLarge, textAlign: TextAlign.center,),
  
SizedBox( height: sizeHeight/30),  

SizedBox( height: sizeHeight/1.7, width: sizeWidth/2,
  child: ListWheelScrollView.useDelegate(itemExtent: sizeHeight/9, physics: FixedExtentScrollPhysics(),  perspective: 0.003,
diameterRatio: 1, onSelectedItemChanged: (index) {
setState(() {
selectedAge = 15 + index; 
});
},
childDelegate: ListWheelChildBuilderDelegate(builder: (context, index){
  
final age = 15 + index; 
final isSelected = age == selectedAge;

return Center(
child: isSelected ? Container( decoration: BoxDecoration(color: theme.primaryColor, borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
border: Border.all(width: 6, color: chipColor)),
child: Center(
  child: Text( "$age",
  style: TextStyle( fontSize:  55, fontWeight: FontWeight.bold, color: whiteColor 
  ),
  ),
)
) :

Text( "$age",
style: TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color:  const Color.fromARGB(137, 53, 4, 4),
),
),
);
  },
childCount: 61,)
  ),
),

SizedBox(height: 20),

elevatedButton(sizeWidth, sizeHeight, (){
ref.read(userInfoProvider.notifier).saveAge(selectedAge);
moveToNextScreen(context, SetExercise());
}, 'Continue')
],
),
),
);
  }
}