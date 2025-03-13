import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfo{
final String userName;
final String fitnessTarget;
final String gender;
final int weight;
final int age;
final String exercisePrefs;

UserInfo({required this.userName, required this.fitnessTarget, required this.gender, required this.weight, required this.age, required this.exercisePrefs});

UserInfo copyWith ({
 String? userName, String? fitnessTarget, String? gender, int? weight, int? age, String? exercisePrefs
})
{
 return UserInfo(
userName: userName ?? this.userName,
fitnessTarget: fitnessTarget ?? this.fitnessTarget, 
gender: gender ?? this.gender, 
weight: weight ?? this.weight, age: age ?? this.age, 
exercisePrefs: exercisePrefs ?? this.exercisePrefs);
}
}


class SaveUserInfo extends StateNotifier<UserInfo> {

SaveUserInfo()
: super(UserInfo(
userName: '', fitnessTarget: '', gender: '', weight: 0, age: 0, exercisePrefs: ''));


Future<void> saveUserName(String name) async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = state.copyWith(userName: name);
await prefs.setString('username', name);
}

Future<void> setFitnessTarget(String fitnessTarget) async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = state.copyWith(fitnessTarget: fitnessTarget);
await prefs.setString('fitnessTarget', fitnessTarget);
}

Future<void> saveGender(String gender) async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = state.copyWith(gender: gender);
await prefs.setString('gender', gender);
}

Future<void> saveWeight(int weight) async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = state.copyWith(weight: weight);
await prefs.setInt('weight', weight);
}

Future<void> saveAge(int age) async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = state.copyWith(age: age);
await prefs.setInt('age', age);
}

Future<void> setExercisePrefs(String prefsValue) async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = state.copyWith(exercisePrefs: prefsValue);
await prefs.setString('exercisePrefs', prefsValue);
}


Future<void> loadUserInfo() async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
state = UserInfo(
userName: prefs.getString('username') ?? '',
fitnessTarget: prefs.getString('fitnessTarget') ?? '',
gender: prefs.getString('gender') ?? '',
weight: prefs.getInt('weight') ?? 0,
age: prefs.getInt('age') ?? 0,
exercisePrefs: prefs.getString('exercisePrefs') ?? '',
);
}
}