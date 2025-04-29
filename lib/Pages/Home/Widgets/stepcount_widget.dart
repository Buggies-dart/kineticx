import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepCountWidget extends StatelessWidget {
  const StepCountWidget({
    super.key,
    required this.sizeHeight,
    required this.sizeWidth,
    required this.theme,
    required this.stepCounts,
    required this.maxStepCounts,
    required this.distance,
    required this.caloriesBurned,
  });

  final double sizeHeight;
  final double sizeWidth;
  final ThemeData theme;
  final int stepCounts;
  final int maxStepCounts;
  final double distance;
  final double caloriesBurned;
  @override
  Widget build(BuildContext context) {
    return Container( height: sizeHeight/3.8, width: sizeWidth, decoration: BoxDecoration( color: theme.colorScheme.surfaceContainer, borderRadius: BorderRadius.all(Radius.elliptical(20, 20)) ),
    
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column( crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text('Steps', style: theme.textTheme.titleMedium),
      Text( stepCounts.toString(), style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black.withValues(alpha: 0.5), fontSize: sizeHeight/30, fontWeight: FontWeight.w900)),
      Text('Steps Today', style: theme.textTheme.bodyMedium),
      Column(
        children: [
          SizedBox( height: 30,
            child: ListTile(
              leading: SizedBox( height: 20, width: 20, child: CircularProgressIndicator( value: stepCounts / maxStepCounts,
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              strokeWidth: 6, backgroundColor: Colors.black.withValues(alpha: 0.1),
              ),
              ),
              title: Text('Steps Remaining', style: theme.textTheme.bodySmall),
              trailing: Text('${maxStepCounts - stepCounts} steps', style: theme.textTheme.bodySmall),
            ),
          ),
        SizedBox( height: 30,
          child: ListTile(
            leading: Icon(FontAwesomeIcons.personWalking, color: theme.primaryColor, size: 22 ),
            title: Text('Distance', style: theme.textTheme.bodySmall),
            trailing: Text('${distance.toStringAsFixed(2)} km', style: theme.textTheme.bodySmall),
            ),
        ),
        SizedBox( height: 30,
          child: ListTile(
            leading: Image.asset('assets/images/kCal.png', color: theme.primaryColor, height: 20, width: 20),
            title: Text('Calories (kcal)', style: theme.textTheme.bodySmall),
            trailing: Text('${caloriesBurned.toStringAsFixed(2)} km', style: theme.textTheme.bodySmall),
            ),
        ),
       
       
        ],
      ),
      ],
      ),
    ),
    );
  }
}





