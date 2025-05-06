import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:kineticx/Firebase/firebase_widgets.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/Assessments/setfitness_target.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/login.dart';
import 'package:kineticx/Utils/constants.dart';

class FirebaseAuthMethods{
final FirebaseAuth _auth;
BuildContext context;
FirebaseAuthMethods(this._auth, this.context);

// SIGN UP WITH EMAIL
Future<void> signUpWithEmail({
required String username, required String email, required String password, required String? phoneNumber

}) async{

try {
  _auth.setLanguageCode('en');
var queryUserNameSnapshot = await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).get();

var queryPhoneSnapshot = await FirebaseFirestore.instance.collection('users').where('phone', isEqualTo: phoneNumber).get();

var queryEmailSnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();

if (queryUserNameSnapshot.docs.isNotEmpty && context.mounted) {
showSnackbar(context, 'Username not available');
return;
}
if (  phoneNumber != null && queryPhoneSnapshot.docs.isNotEmpty && context.mounted) {
showSnackbar(context, 'Your phone number is already linked to another account');
}
else if(phoneNumber == null){
return;
}

if (queryEmailSnapshot.docs.isNotEmpty && context.mounted) {
showSnackbar(context, 'The email address is already linked to another account');
return;
}

UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

if (userCredential.user == null) {
throw FirebaseAuthException(code: 'ERROR_NULL_USER', message: 'User creation failed.');
}

// Add user to Firestore if sign-up succeeds
String uid = userCredential.user!.uid;
await FirebaseFirestore.instance.collection('users').doc(uid).set({
'username': username,
'email': email,
'phone': phoneNumber,
'createdAt': FieldValue.serverTimestamp(),
});
await Future.delayed(Duration(seconds: 2)); 
await userCredential.user?.reload();
User? updatedUser = _auth.currentUser;

if (updatedUser != null) {
if (context.mounted) {
pushReplacement(context, SetFitnessTarget());
}

}

} on FirebaseAuthException catch (e) {
final errorMessage = e.message ?? 'An unexpected error occurred';
if (context.mounted) {
showSnackbar(context, errorMessage);
}
}  
}


// SIGN IN WITH GOOGLE
Future<void> signinWithGoogle() async {
  try {
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
if (googleUser == null) {
if (context.mounted) {
showSnackbar(context, "Google Sign-In was canceled.");
}
return;
}

final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

if (googleAuth.accessToken != null && googleAuth.idToken != null) {
final credential = GoogleAuthProvider.credential(
accessToken: googleAuth.accessToken,
idToken: googleAuth.idToken,
);

      // Sign in with Firebase using the credentials
UserCredential userCredential = await _auth.signInWithCredential(credential);
final user = userCredential.user;

if (user != null) {
final FirebaseFirestore firestore = FirebaseFirestore.instance;
DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();

if (!userDoc.exists) {
await firestore.collection('users').doc(user.uid).set({
'username': user.displayName ?? 'No Name',
'email': user.email,
'createdAt': FieldValue.serverTimestamp(),
});
if (context.mounted) {
pushReplacement(context, SetFitnessTarget());
}
} else if (userDoc.exists) {
if (context.mounted) {
pushReplacement(context, NavigationPage());
}
}
}
}
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
showSnackbar(context, e.message ?? "An error occurred during sign-in.");
}
  } catch (e) {
if (context.mounted) {
showSnackbar(context, "Something went wrong: $e");
}
}
}



// USER SIGN IN
Future<void> userSignin({required String mail, required String password})async{
 try {
await _auth.signInWithEmailAndPassword(email: mail, password: password);

User? updatedUser = _auth.currentUser;

if (updatedUser != null) {
if (context.mounted) {
pushReplacement(context, NavigationPage());
}

}
 } on FirebaseAuthException catch (e) {
  if (context.mounted) {
showSnackbar(context, e.message!);
} 
}
}

// Phone Sign In

Future<void> phoneSigning(String phoneNumber) async{

try {

var querySnapshot = await FirebaseFirestore.instance.collection('users').where('phone', isEqualTo: phoneNumber).get();
TextEditingController codeController = TextEditingController();

if (querySnapshot.docs.isNotEmpty) {
_auth.verifyPhoneNumber(
phoneNumber: phoneNumber,
verificationCompleted: (PhoneAuthCredential credential) async {
await _auth.signInWithCredential(credential);
},  
verificationFailed: (e){showSnackbar(context, 'Verfication Failed');}, 

codeSent: ((String verficationId, int? resendToken) { 
showdialogBox(context: context, codeController: codeController, onPressed: () async{
PhoneAuthCredential credential = PhoneAuthProvider.credential(
  verificationId: verficationId, smsCode: codeController.text.trim()
);
  await _auth.signInWithCredential(credential); }, phoneController: codeController);
}), 
codeAutoRetrievalTimeout: (String verficationId){});

} else {
  if (context.mounted) {
showSnackbar(context, 'No number is associated with this account.');
  }
}

} on FirebaseAuthException catch(e) {
  if (context.mounted) {
  showSnackbar(context, 'Some error occurred: $e');
  }
}

}

// Reset Password via Email

Future<void> resetPassword({required String email}) async{
try {
  _auth.sendPasswordResetEmail(email: email);
 if (context.mounted) {
showSnackbar(context, 'Password reset email sent. Check your inbox.');
}
}  on FirebaseAuthException catch (e) {
final String errorMessage = e.message ?? 'Failed to send email';
showSnackbar(context, errorMessage);
}
}

// LOG OUT USERS
Future<void> signOutUser() async {
try {
logOutOrDeleteAcct(context, 'Sign out', 'Signing out will remove all ${AppConstants.appName} data from this device.', ()async{
await _auth.signOut();
if (context.mounted) {
 moveToNextScreen(context, Login()); 
}
 });
}  on FirebaseAuthException catch (e) {
final String errorMessage = e.message ?? 'Sign out fail, try again later';

showSnackbar(context, errorMessage);
}

}

}
