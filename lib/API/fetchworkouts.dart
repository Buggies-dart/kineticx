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

 List<Map<String, dynamic>> bodyPartsWithImages = body.map((dynamic item) {
String word = item.toString();
return  {'bodyPart': word[0].toUpperCase() + word.substring(1), 'image': getImageForBodyPart(word)};
}).toList();

return  bodyPartsWithImages;
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


Future<List<String>> target() async {
final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/target/abductors?limit=10&offset=0');
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
print('Target Exercise: $body');
return body.map((dynamic item) => item.toString()).toList();
}
else {
throw Exception('Failed to load exercises from API: ${response.statusCode}');
}
}

Future<List<String>> bodyPart() async {
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
print(body);
return body.map((dynamic item) => item.toString()).toList();
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
}