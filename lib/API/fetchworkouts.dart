import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class ExerciseDBApi {

static Future<List<Map<String, dynamic>>> bodyPartList() async {

final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPartList');
String apiKey = Platform.environment['API_KEY'] ?? 'default_value';

if (apiKey.isEmpty) {
throw Exception('API key is missing. Set the API_KEY environment variable.');
}

final response = await http.get(url,
headers: {
  'X-RapidAPI-Key' : 'f7909e53admshf1e995473477e5ep1e304bjsn9e0a92902361',
  'X-RapidAPI-Host' : 'exercisedb.p.rapidapi.com'
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
 // Function to map body part to image
static String getImageForBodyPart(String bodyPart) {
switch (bodyPart.toLowerCase()) {
case 'chest': return 'assets/chest_image.png';
case 'back': return 'assets/back_image.png';
case 'arms': return 'assets/arms_image.png';
case 'shoulders': return 'assets/shoulders_image.png';
case 'legs': return 'assets/legs_image.png';
case 'abs': return 'assets/abs_image.png';
case 'glutes': return 'assets/glutes_image.png';
case 'calves': return 'assets/calves_image.png';
default: return 'assets/default_image.png'; 
}
}
}