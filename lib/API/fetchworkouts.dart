import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kineticx/Utils/pngs.dart';


class ExerciseDBApi {
String apiKey =  "f7909e53admshf1e995473477e5ep1e304bjsn9e0a92902361";
String apiHost = "exercisedb.p.rapidapi.com";

Future<List<Map<String, dynamic>>> bodyPartList() async {
final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPartList');

if (apiKey.isEmpty) {
throw Exception('API key is missing. Set the API_KEY environment variable.');
}

final response = await http.get(url,
headers: {
  'X-RapidAPI-Key' : apiKey,
  'X-RapidAPI-Host' : apiHost,
});
if (response.statusCode == 200) {
List<dynamic> body = jsonDecode(response.body);

 List<Map<String, dynamic>> bodyPartListWithImages = body.map((dynamic item) {
String word = item.toString();
return  {'bodyPart': word[0].toUpperCase() + word.substring(1), 'image': getImageForBodyPart(word)};
}).toList();
 final bodyPartListWithImageshuffled = bodyPartListWithImages.toList()..shuffle();
return  bodyPartListWithImageshuffled;
} else {
throw  Exception('Failed to load exercises from API: ${response.statusCode}');
}
}



Future<List<String>> targetBodyParts() async {
final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/targetList');
if (apiKey.isEmpty) {
throw Exception('API key is missing. Set the API_KEY environment variable.');
}
final response = await http.get(url,
headers: {
  'X-RapidAPI-Key' : apiKey,
  'X-RapidAPI-Host' : apiHost,
});
if (response.statusCode == 200) {
List<dynamic> body = jsonDecode(response.body);
print(' Target List: $body');
return body.map((dynamic item) => item.toString()).toList();
}
else {
throw Exception('Failed to load exercises from API: ${response.statusCode}');
}
}


Future<List<String>> targetBodyPartList() async {
final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPart/back?limit=10&offset=0');
if (apiKey.isEmpty) {
throw Exception('API key is missing. Set the API_KEY environment variable.');
}
final response = await http.get(url,
headers: {
  'X-RapidAPI-Key' : apiKey,
  'X-RapidAPI-Host' : apiHost,
});
if (response.statusCode == 200) {
List<dynamic> body = jsonDecode(response.body);
print('Target Exercise Are Listed: $body');
return body.map((dynamic item) => item.toString()).toList();
}
else {
throw Exception('Failed to load exercises from API: ${response.statusCode}');
}
}

Future<List<Map<String, dynamic>>> bodyPart(String body) async {
final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPart/$body?limit=10&offset=0');
if (apiKey.isEmpty) {
throw Exception('API key is missing. Set the API_KEY environment variable.');
}
final response = await http.get(url,
headers: {
  'X-RapidAPI-Key' : apiKey,
  'X-RapidAPI-Host' : apiHost,
});
if (response.statusCode == 200) {
List<dynamic> body = jsonDecode(response.body);
print(body);

final List<Map<String, dynamic>> bodyPartsWithImages = body.map((dynamic item){
String word = item.toString(); String nameUperCase = item['name'];
List instructions = item['instructions'] ?? ''; 
List secondaryMuscles = item['secondaryMuscles'];
return {
  'id': item['id'],
  'name': nameUperCase[0].toUpperCase() + nameUperCase.substring(1),
  'gifUrl': item['gifUrl'],
  'bodyPart': word[0].toUpperCase() + word.substring(1),
  'target': item['target'],
  'equipment': item['equipment'],
  'secondaryMuscles': secondaryMuscles,
  'description': item['description'],
  'instructions': instructions,
  'image': getImageForBodyPart(word),
  'preview': getTextPreviews(word),
};
}).toList();
return bodyPartsWithImages;
}
else {
throw Exception('Failed to load exercises from API: ${response.statusCode}');
}
}




 // Function to map body part to image
  String getImageForBodyPart(String bodyPart) {
switch (bodyPart.toLowerCase()) {
case 'chest': return Images.chestImage;
case 'back': return Images.backImage;
case 'cardio': return Images.cardioImage;
case 'lower arms': return Images.lowerarmsImage;
case 'legs': return 'assets/images/sportywoman.png';
case 'abs': return 'assets/images/sportywoman.png';
case 'glutes': return 'assets/images/sportywoman.png';
case 'calves': return 'assets/images/sportywoman.png';
default: return 'assets/images/sportywoman.png';
}
}

 static String getTextPreviews(String bodyPart) {
switch (bodyPart.toLowerCase()) {
case 'chest': return 'Build a powerful, defined chest with our chest-focused workouts. Tone your pecs, increase strength, and develop a muscular upper body with exercises that push you to new limits, perfect for all fitness levels.';
case 'back': return 'Strengthen and tone your back muscles with targeted exercises designed to improve posture, increase flexibility, and reduce the risk of injury. Achieve a sculpted, balanced look with our easy-to-follow, guided back workouts.';
case 'cardio': return  'Boost your cardiovascular health and endurance with our dynamic cardio workouts. From high-intensity interval training to steady-state exercises, find the perfect routine to elevate your heart rate and burn calories effectively.';
case 'lower arms': return 'Enhance your grip strength and forearm definition with our lower arm workouts. Targeted exercises will help you build muscular forearms, improve your overall arm strength, and enhance your performance in various sports and activities.';
case 'lower legs': return 'Strengthen and shape your calves and lower legs with effective workouts designed to boost stability and athletic performance. From calf raises to dynamic movements, these exercises will help you achieve balanced, strong legs';
case 'upper legs': return 'Sculpt and tone your upper legs with a variety of challenging workouts that focus on your quads, hamstrings, and glutes. Enhance leg strength, improve balance, and build lean muscle with our dynamic routines';
case 'waist': return 'Shape and define your waistline with workouts that focus on core strength, stability, and toning. Target obliques, lower abs, and more for a sculpted, lean midsection that enhances your overall fitness profile.';
case 'neck': return 'Improve your neck strength and mobility with specialized exercises designed to reduce tension and enhance posture. Develop a strong, supportive neck to complement your fitness routine and prevent neck strain.';
default: return 'Explore a dynamic fitness app offering specialized workouts for back, cardio, chest, lower arms, lower legs, upper legs, waist training, and neck. Transform your body with guided routines, progress tracking, and real-time feedback. Achieve your goals today!';
}
}
}