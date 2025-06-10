import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';


class WorkoutPage extends ConsumerStatefulWidget {
  const WorkoutPage({super.key, required this.workout});
final Map<String, dynamic> workout;
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


return Scaffold(
floatingActionButton: Material( elevation: 10, shadowColor: Colors.black,
  child: Container( color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5),
  width: sizeWidth, height: sizeHeight / 12,
  child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  CircleAvatar(backgroundColor: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3), child: Icon(Icons.skip_previous,),),
  Text('1/10', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),
  CircleAvatar(backgroundColor: theme.primaryColor.withValues(alpha: 0.5), child: Icon(Icons.skip_next, color: theme.primaryColor.withValues(alpha: 0.9),),),
  
SizedBox( width: sizeWidth/2, height: sizeHeight/15,
  child: ElevatedButton(onPressed: (){Navigator.pop(context);}, style:  ElevatedButton.styleFrom( backgroundColor: textColorBlack,
  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30))),
  child: Text('Close',   style:TextStyle(fontSize: 16, color: whiteColor))),
),
  ],
  ),
  ),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
body: SingleChildScrollView( scrollDirection: Axis.vertical,
  child: SafeArea(child: 
  Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
    Text("WORKOUT", style:  theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w900,fontSize: 25),), 
  Image.asset(Buttons.replace, width: 40, height: 40, color: theme.primaryColor,),
       ],
     ),
    
    SizedBox( height: sizeHeight/60,),
  
  Container(
  width: sizeWidth, height: sizeHeight / 3,
  decoration: BoxDecoration(
  image: DecorationImage(
    image: NetworkImage(widget.workout['gifUrl']), // Replace with your image path
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
  Text(widget.workout['description'].toString(), style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),),
   
   SizedBox( height: sizeHeight/40,),
  Text('INSTRUCTIONS', style: theme.textTheme.titleMedium!.copyWith(color: theme.primaryColor, fontSize: 20)),
  Text(widget.workout['instructions'].toString(), style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),),
   
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
Text(widget.workout['target'], style: theme.textTheme.titleMedium,),
      
],),
),

SizedBox( height: sizeHeight/15, width: sizeWidth/1.3,
child: ListView.builder( scrollDirection: Axis.horizontal, itemCount: 2 , padding: EdgeInsets.only(top: 0),
itemBuilder: (context, index) => 
Row( 
children: [Padding( padding: const EdgeInsets.only(left: 10),
  child: Container(  height: sizeHeight/20, padding: const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration( color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
  child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  Icon(Icons.circle, color: theme.primaryColor, size: 20,), 
  SizedBox(width: 5),
  Text(widget.workout['secondaryMuscles'][index], style: theme.textTheme.titleMedium, overflow: TextOverflow.ellipsis,),
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
));
    
  }
}