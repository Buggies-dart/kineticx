import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/API/fetchworkouts.dart';




final bodyPartTarget = FutureProvider<List<String>>((ref) async {
return await ExerciseDBApi().targetBodyParts();
});


final bodyPartList = FutureProvider<List<Map<String, dynamic>>>((ref) async {
return await ExerciseDBApi().bodyPartList();
});