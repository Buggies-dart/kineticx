import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
body: SafeArea(child: Column( 
children: [
 Text("Workout", style:  theme.textTheme.titleMedium),

 Container(
width: sizeWidth, height: sizeHeight / 4,
 decoration: BoxDecoration(
  image: DecorationImage(
image: NetworkImage(widget.workout['gifUrl']), // Replace with your image path
    fit: BoxFit.cover,
  ),
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
BoxShadow( color: Colors.black26, blurRadius: 10, offset: Offset(0, 5),
    ),
  ],
 )
)]),
));
    
  }
}