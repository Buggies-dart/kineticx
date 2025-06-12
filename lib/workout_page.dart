import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Pages/Popular%20Workouts%20Page/popular_workout_page.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/main.dart';


class WorkoutPage extends ConsumerStatefulWidget {
  const WorkoutPage({super.key, required this.workout, required this.index});
final List<Map<String, dynamic>> workout;
final int index;
  @override
  ConsumerState<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends ConsumerState<WorkoutPage> {
  @override
  Widget build(BuildContext context) {

   // Get the theme from the context
  final theme = Theme.of(context);
  
// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

// Workout Title
final String workoutTitle = widget.workout[widget.index]['name'] ?? 'Workout';

return PopScope(
canPop: false,
onPopInvoked: (didPop){
if (!didPop) {
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
final bodyPart = ref.read(bodyandImageProvider).bodyPart;
final imageUrl = ref.read(bodyandImageProvider).imageUrl;
return PopularWorkoutPage(bodyPart: bodyPart, imageUrl: imageUrl);
}), (route) => false);
}
} ,
  child: Scaffold(
  floatingActionButton: floatingActionButton(theme, sizeWidth, sizeHeight, context, ref),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  body: SingleChildScrollView( scrollDirection: Axis.vertical,
    child: SafeArea(child: 
    Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
      SizedBox( width: sizeWidth/1.5,
    child: Text(workoutTitle.toUpperCase(), overflow: TextOverflow.fade, style:  theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w900,fontSize: 17),)), 
    
    InkWell( onTap: (){
showModalBottomSheet( context: context, builder: (context) {
  return Container(
  height: sizeHeight,  width: double.infinity, padding: EdgeInsets.all(16), 
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(children: [
Container( width: sizeWidth/4, height: sizeHeight/10, decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.1),),
child:  Image.network(widget.workout[widget.index]['gifUrl'], width: 30, height: 30),
),
SizedBox( width: sizeWidth/20,),
Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(widget.workout[widget.index]['name'], style: theme.textTheme.titleMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w600),),
Text('Replace it with...', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.w900),),
],)
],
),
SizedBox( height: sizeHeight/30,),

SizedBox( height: sizeHeight/15,
  child: TextField( 
  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), 
  filled: true, fillColor: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.1), prefixIcon: Icon(Icons.search, size: 30, color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.1),),
  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), hintText: 'Search workouts by name or difficulties' , hintStyle: theme.textTheme.headlineMedium!.copyWith(
  color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3))), 
  ),
),

SizedBox( height: sizeHeight/30,),
Text('Similar Workouts', style: theme.textTheme.titleMedium!.copyWith( color: theme.primaryColor ),),

Expanded( 
  child: ListView.builder(  itemCount: widget.workout.length, itemBuilder: (context, index) {
  if (index == widget.index) return SizedBox.shrink(); 
  if (widget.workout[index]['name'] == widget.workout[widget.index]['name']) return SizedBox.shrink();
  final difficultyLevel = widget.workout[index]['difficulty'][0].toUpperCase() + widget.workout[index]['difficulty'].substring(1);
  
  return ListTile( onTap: () {
Navigator.pop(context);
moveToNextScreen(context, WorkoutPage(workout: widget.workout, index: index));
  },
  leading: CircleAvatar( backgroundImage: NetworkImage(widget.workout[index]['gifUrl']), radius: 30,),
  title: Text(widget.workout[index]['name'], style: theme.textTheme.titleMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w900),),
  subtitle: Text('Difficulty: $difficultyLevel', style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),

    );
  },
  ),
),
],
  )
    );
  },
);

    },
child: Image.asset(Buttons.replace, width: 35, height: 35, color: theme.primaryColor,)),
         ],
       ),
      
      SizedBox( height: sizeHeight/60,),
    
    Container(
    width: sizeWidth, height: sizeHeight / 3,
    decoration: BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(widget.workout[widget.index]['gifUrl']), // Replace with your image path
    fit: BoxFit.cover,),
      borderRadius: BorderRadius.circular(10),
       )
      ),
    SizedBox( height: sizeHeight/40,),
     Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('DURATION', style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor, fontSize: 20),),
    SizedBox( width: sizeWidth/2.5,
      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Container( height: 40, width: 40, decoration: BoxDecoration(color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3),
     borderRadius: BorderRadius.all(Radius.elliptical(10, 10)) ),
    child:  IconButton(onPressed: (){}, icon: Icon(Icons.remove),) ),
      Text('00:20', style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w900, fontSize: 22 ),),
     Row(
    children: [
    Container( height: 40, width: 40, decoration: BoxDecoration(color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3),
    borderRadius: BorderRadius.all(Radius.elliptical(10, 10))),
    child: IconButton(onPressed: (){}, icon: Icon(Icons.add),) )
    ],
    ),
      ],
      ),
    ),
    
    ],
     ),
     SizedBox( height: sizeHeight/40,),
    Text('DESCRIPTIONS', style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor, fontSize: 20)),
    Text(widget.workout[widget.index]['description'].toString(), style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),),
     
     SizedBox( height: sizeHeight/40,),
    Text('INSTRUCTIONS', style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor, fontSize: 20)),
    Text(widget.workout[widget.index]['instructions'].toString(), style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),),
     
     SizedBox( height: sizeHeight/40,),
    Text('FOCUS AREA', style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor, fontSize: 20)),
    SingleChildScrollView( scrollDirection: Axis.horizontal,
  
  child: Row(
  children: [ 
  Container( height: sizeHeight/20, padding:  const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration( color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
  child: Row( 
  children: [
  Icon(Icons.circle, color: theme.primaryColor, size: 20,), 
  SizedBox(width: 5),
  Text(widget.workout[widget.index]['target'], style: theme.textTheme.titleMedium,),
        
  ],),
  ),
  
  SizedBox( height: sizeHeight/15, width: sizeWidth/1.3,
  child: ListView.builder( physics: NeverScrollableScrollPhysics(), scrollDirection: Axis.horizontal, itemCount: widget.workout[widget.index]['secondaryMusclesLength'], padding: EdgeInsets.only(top: 0),
  itemBuilder: (context, index) => 
  Row( 
  children: [Padding( padding: const EdgeInsets.only(left: 10),
    child: Container(  height: sizeHeight/20, padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration( color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Icon(Icons.circle, color: theme.primaryColor, size: 20,), 
    SizedBox(width: 5),
    Text(widget.workout[widget.index]['secondaryMuscles'][index] ?? '', style: theme.textTheme.titleMedium, overflow: TextOverflow.ellipsis,),
    ],),
    ),
  ),
  ]),
     
  ),
        ),
        ]),
    ),
     SizedBox( height: sizeHeight/10,),
      ]
    ),
    ),
    ),
  )),
);
    
}

Material floatingActionButton(ThemeData theme, double sizeWidth, double sizeHeight, BuildContext context, WidgetRef ref) {

bool isFirstWorkout = widget.index + 1 == 1;
bool isLastWorkout = widget.index + 1 == widget.workout.length;

return Material( elevation: 10, shadowColor: Colors.black,
child: Container( color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5),
width: sizeWidth, height: sizeHeight / 12,
child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [

InkWell(onTap: isFirstWorkout ? () {} : (){
moveToNextScreen(context, WorkoutPage(workout: widget.workout, index: widget.index - 1));
},
child: CircleAvatar(backgroundColor: isFirstWorkout ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3) : theme.primaryColor.withValues(alpha: 0.5), child: Icon(Icons.skip_previous, color: isFirstWorkout ? null : theme.primaryColor.withValues(alpha: 1), ),)),

Text('${widget.index + 1}/${widget.workout.length}', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),

InkWell( onTap:  isLastWorkout? (){} : () {
moveToNextScreen(context, WorkoutPage(workout: widget.workout, index: widget.index + 1));},
child: CircleAvatar(backgroundColor: isLastWorkout? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3): theme.primaryColor.withValues(alpha: 0.5), child: Icon(Icons.skip_next, color:  isLastWorkout? null: theme.primaryColor.withValues(alpha: 1),),)),

SizedBox( width: sizeWidth/2, height: sizeHeight/15,
child: ElevatedButton(onPressed: (){
final body = ref.read(bodyandImageProvider).bodyPart;
final image = ref.read(bodyandImageProvider).imageUrl;
moveToNextScreen(context, PopularWorkoutPage(bodyPart: body, imageUrl: image));
}, style:  ElevatedButton.styleFrom( backgroundColor: textColorBlack,
shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30))),
child: Text('Close',   style:TextStyle(fontSize: 16, color: whiteColor))),
),
],
),
),
);
  }
}