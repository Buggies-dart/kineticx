import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/API/controllers/api_controller.dart';
import 'package:kineticx/API/fetchworkouts.dart';
import 'package:kineticx/Navigation/navigation.dart' show moveToNextScreen;
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Widgets/shimmers.dart';
import 'package:kineticx/workout_page.dart';

class PopularWorkoutPage extends ConsumerStatefulWidget {
  const PopularWorkoutPage({super.key, required this.bodyPart, required this.imageUrl});
final String bodyPart; final String imageUrl;
  @override
  ConsumerState<PopularWorkoutPage> createState() => _PopularWorkoutPageState();
}

class _PopularWorkoutPageState extends ConsumerState<PopularWorkoutPage> {

  @override
  Widget build(BuildContext context) {

  // Get the theme from the context
  final theme = Theme.of(context);

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

// State Management

final bodyPartAsyncValue = ref.watch(bodyPart(widget.bodyPart.toLowerCase()));

return Scaffold( backgroundColor: Colors.black, 
floatingActionButton: SizedBox( width: sizeWidth/1.15,
child: FloatingActionButton.extended( backgroundColor: theme.primaryColor, onPressed: (){}, label: Text('Start Workout', style: theme.textTheme.titleMedium!.copyWith(fontSize: 16)),
elevation: 20,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
body: SafeArea(
  child: SingleChildScrollView( scrollDirection: Axis.vertical,
    child: Column(
    children: [
    
    Row(children: [
    IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: whiteColor,)),
    SizedBox(width: sizeWidth * 0.3),
    Text("Workout", style:  theme.textTheme.titleMedium!.copyWith(color: whiteColor),),
     ],
    ),
    Padding( padding: EdgeInsets.all(20),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
      children: [
      Stack( clipBehavior: Clip.none, alignment: Alignment.center, 
      children: [ 
      Container( height: sizeHeight/4, width: sizeWidth/1.1, 
      decoration: BoxDecoration( image: DecorationImage( image: AssetImage(widget.imageUrl), fit: BoxFit.cover),
       borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),   ),
      ),
      Positioned( bottom: -1.8,
      child: Container( 
      decoration: BoxDecoration(gradient: LinearGradient( begin: Alignment.topCenter, end: Alignment.bottomCenter,
      colors: [
      Color(0xFF686868).withValues(alpha: 0.1), Color(0xFF1D1D1D).withValues(alpha: 0.9)
      ]),
  borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
      ),
      height: sizeHeight/10, width: sizeWidth/1.105,
      ),
      ), 
      Positioned( left: sizeWidth/8, top: sizeHeight/5,
      child: Stack(
        children: [ ClipRRect( borderRadius: BorderRadius.circular(15),
        child: BackdropFilter( filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ShaderMask( shaderCallback: (bounds) => LinearGradient( colors: [
        theme.primaryColor.withValues(alpha:1), theme.primaryColor.withValues(alpha: 0.01), theme.primaryColor.withValues(alpha:0),
        theme.primaryColor.withValues(alpha: 0.01), theme.primaryColor.withValues(alpha:1), 
        ],
        stops: [0.0, 0.41, 0.47, 0.54, 1.0],
        ).createShader(bounds),
        child: Container( width: 260, height: 75, decoration: BoxDecoration(
        color: Color(0xFF192126).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(15),  border: Border.all(color: Colors.white, width: 0.2),
        ),
        ),
        ),
        ),),
      
      Positioned( top: 12, left: 12,
      child: Row( 
      children: [
      workoutParams(theme, 'Time', '30 min', Icons.access_time),
      SizedBox(width: sizeWidth/15),
      Container(width: 1, height: sizeHeight/18, color: Colors.grey,
      ),
      SizedBox(width: sizeWidth/15),
      workoutParams(theme, 'Burn', '95 kCal', MdiIcons.fire), 
      ],
      ),
      ),
      ]),
      ),
      ]
      
      ),
      
      
       Container( 
      decoration: BoxDecoration( gradient: LinearGradient(colors: [
      theme.primaryColor.withValues(alpha:1), theme.primaryColor.withValues(alpha: 0.01), theme.primaryColor.withValues(alpha:0),
      theme.primaryColor.withValues(alpha: 0.01), theme.primaryColor.withValues(alpha:1), 
      ],
      stops: [0.0, 0.41, 0.47, 0.54, 1.0],
      ) ),),
      SizedBox(height: sizeHeight/15),
      
Text('${widget.bodyPart} Workout', style: theme.textTheme.titleMedium!.copyWith(color: whiteColor, fontSize: 20)),

SizedBox(height: sizeHeight/50),

Text(ExerciseDBApi.getTextPreviews(widget.bodyPart), style: theme.textTheme.bodyMedium!.copyWith(color: whiteColor.withValues(alpha: 0.5), fontSize: 14)),
      
SizedBox(height: sizeHeight/15),
      
Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text('Rounds', style: theme.textTheme.titleMedium!.copyWith(color: whiteColor, fontSize: 20)),
Text('1/8', style: theme.textTheme.headlineMedium!.copyWith(color: whiteColor),)
]),
bodyPartAsyncValue.when(
data: (bodyParts) => SizedBox(
height: sizeHeight + sizeHeight/6, width: sizeWidth, child: ListView.builder(
physics: NeverScrollableScrollPhysics(), itemCount: bodyParts.length, scrollDirection: Axis.vertical,
itemBuilder: (context, index) {
print('Body Part: ${bodyParts[index]['name']}');
return Padding( padding: const EdgeInsets.only( bottom: 8, top: 8),
child: SizedBox( height: sizeHeight / 10,
child: InkWell( onTap: (){  moveToNextScreen(context, WorkoutPage(workout: bodyParts[index],));
},
  child: ListTile( tileColor: darkSlateGray, contentPadding:
  EdgeInsets.only( left: 10, right: 10, top: 5),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20)),
  leading: Container(
   width: 50, height: 50,
  decoration: BoxDecoration(
  image: DecorationImage( image: NetworkImage(bodyParts[index]['gifUrl']), fit: BoxFit.cover),
  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
  ),
  
  ), 
  title: Text(bodyParts[index]['name'], overflow: TextOverflow.ellipsis, maxLines: 1, style: theme.textTheme.titleMedium!.copyWith(color: whiteColor, fontSize: 16)),
  subtitle: Text('00.35'), trailing: Icon(Icons.play_circle_fill,
  color: theme.primaryColor, size: 30),
  ),
),
),
);
}),
  ),
loading: () => SizedBox( height: sizeHeight, width: sizeWidth,
  child: ListView.builder( physics: NeverScrollableScrollPhysics(), itemCount: 10, itemBuilder: (context, index){ return
  Padding(  padding: EdgeInsets.only(top: 8, bottom: 8),
  child: ShimmerWidget(sizeHeight:  sizeHeight/10, sizeWidth: sizeWidth));
    }),
),
  error: (error, stack) => Center(
child: Text('Error: $error',
style: theme.textTheme.bodyMedium!.copyWith(color: Colors.red))),
)
],
),
    ),
SizedBox(height: 100),
      ]),
  ),
)
    );
  }

  
  
Row workoutParams(ThemeData theme, String text, String parameter, IconData icon) {
return Row(
children: [
Container( width: 40, height: 40, decoration: BoxDecoration(color: theme.primaryColor, borderRadius: BorderRadius.all(Radius.elliptical(5, 5))),
child: Icon(icon)
),
SizedBox(width: 6),
Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(text, style: theme.textTheme.titleMedium!.copyWith(color: whiteColor, fontSize: 12)),
Text(parameter, style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor, fontSize: 14)),
],
)
],
);
  }
}


