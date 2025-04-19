import 'package:flutter/material.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';

class SetExercise extends StatefulWidget {
  const SetExercise({super.key});

  @override
  State<SetExercise> createState() => _SetExerciseState();
}

class _SetExerciseState extends State<SetExercise> {


 int? selectedIndex;
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return Scaffold( backgroundColor: scaffold,
body: SafeArea(
  child: Column(
  children: [
   Row(
  children: [
  arrowBackIcon(context),
  
  SizedBox(width: sizeWidth/30),
  
  Text('Assessment', style: theme.textTheme.displayLarge,),
  
  SizedBox(width: sizeWidth/4.5),
  
  Chip( backgroundColor:  chipColor, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal( left: Radius.elliptical(15, 15),
   right: Radius.elliptical(15, 15))),
  label: Text('5 of 5', style: TextStyle( fontSize: 20, color: theme.primaryColor, ),)),
  ],
  ),
  
  SizedBox( height: sizeHeight/20),
  
  Text('Do you have specific\nExercise Preference?', style: theme.textTheme.labelLarge, textAlign: TextAlign.start,),
  
  SizedBox( height: sizeHeight/30),
  
  Expanded(
  child: GridView.builder( itemCount: exercisePrefs.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10), itemBuilder: (context, index){
  final exercisePref = exercisePrefs[index];
bool isSelected = selectedIndex == index;   
  
  return Padding(
  padding:  EdgeInsets.only(left: 10, right: 7),
  child: GestureDetector( onTap: (){
  setState(() {
    selectedIndex = index;
  });
  },
child: exercisesContainer(isSelected, theme, exercisePref),
  ),
  );
  }),
  ),
  
elevatedButton(sizeWidth, sizeHeight, (){
moveToNextScreen(context, NavigationPage());
  }, 'Finish')
  ],
  ),
),
);
}

  Container exercisesContainer(bool isSelected, ThemeData theme, Map<dynamic, dynamic> exercisePref) {
    return Container( decoration: BoxDecoration( color:  isSelected ? theme.primaryColor : theme.colorScheme.surfaceContainer,
  borderRadius: BorderRadius.all(Radius.elliptical(30, 30)), border: Border.all(width: isSelected? 7 : 0, color: chipColor
  )),
  child: Column( mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Icon(exercisePref['icon'], size: 45, color: theme.colorScheme.onPrimaryContainer),
  Text(exercisePref['exercise'], style: theme.textTheme.headlineMedium)
  ],
  ),
  );
  }
}

List<Map> exercisePrefs = [
{
'icon' : Icons.directions_run,
'exercise' : 'Jogging'
},
{
'icon' : Icons.run_circle,
'exercise' : 'Running'
},
{
'icon' : Icons.hiking,
'exercise' : 'Hiking'
},
{
'icon' : Icons.skateboarding,
'exercise' : 'Skating'
},
{
'icon' : Icons.pedal_bike,
'exercise' : 'Biking'
},
{
'icon' : Icons.fitness_center,
'exercise' : 'Weightlifting'
},
{
'icon' : Icons.flash_on,
'exercise' : 'Cardio'
},
{
'icon' : Icons.self_improvement,
'exercise' : 'Yoga'
},
{
'icon' : Icons.settings,
'exercise' : 'Other'
},

];
