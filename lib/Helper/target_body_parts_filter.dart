import 'package:kineticx/API/fetchworkouts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getbodyPartFilter() async{
final  prefs = await SharedPreferences.getInstance();
final getFitnessTarget = prefs.getString('fitnessTarget');

List<String> allBodyParts =  await ExerciseDBApi().targetBodyParts();

if (allBodyParts.isEmpty) {
  return [];
}
List<int> targetIndexes = [];

if (getFitnessTarget == 'Weightloss') {
  targetIndexes = [0, 3, 7, 9]; 
  } else if (getFitnessTarget == 'Endurance') {
    targetIndexes = [1, 4, 6, 8];
  } else if (getFitnessTarget == 'Muscle') {
    targetIndexes = [2, 5, 8, 10];
  } else if (getFitnessTarget == 'Just trying out the app' || getFitnessTarget == 'Testing the AI') {
    targetIndexes = List.generate(allBodyParts.length, (index) => index); 
  }
 final filtered = targetIndexes.map((i) => allBodyParts[i]).toList();
 print(filtered);
 return filtered;
}