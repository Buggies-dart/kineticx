import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/API/fetchworkouts.dart';

class HomeController {
//  Username
static final userName =   FutureProvider<String?>((ref) async {
  final userId = FirebaseAuth.instance.currentUser?.uid; 
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userDoc.exists) {
    return userDoc.data()?['username'] as String?;
  } else {
    throw Exception('');
  }
});

// Popular Workouts

static final bodyPartList = FutureProvider<List<Map<String, dynamic>>>((ref) async {
return await ExerciseDBApi().bodyPartList();
});
}
