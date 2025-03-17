import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kineticx/Firebase/firebase_auth.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Pages/Onboarding%20screens/Widgets/phone_number.dart';
import 'package:kineticx/Pages/Onboarding%20screens/login.dart';
import 'package:kineticx/Widgets/textfield.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/components.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 bool isLoading = false;
 bool obscureText = true;
final TextEditingController controllerName = TextEditingController();
final TextEditingController controllerMail = TextEditingController();
final TextEditingController controllerPass = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);
return  Scaffold( backgroundColor: whiteColor,

body:
SingleChildScrollView( scrollDirection: Axis.vertical,
  child: Column( crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Stack(
children: [
   Container( height: sizeHeight/3,
decoration: BoxDecoration(
image: DecorationImage(image: AssetImage('assets/images/chestpress.png'), fit: BoxFit.cover)
),
),
  
  Positioned.fill( top: 50, bottom: sizeHeight/15,
    child: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient( begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [
    Color.fromARGB(0, 255, 255, 255), whiteColor
    ]) 
    ),
    ),
  ),
  
  Padding(
  padding:  EdgeInsets.only(top: sizeHeight/20),
  child: Column( 
      children: [
  SizedBox( height: sizeHeight/10),
  Center(child: Image.asset('assets/images/applogo.png', width: sizeWidth/5,)),
  Column(
      children: [
  Text('Sign Up For Free', style: theme.textTheme.displayLarge),
      
  Padding(
  padding: const EdgeInsets.only(top: 10),
  child: Text('Quickly create your account in 1 minute', style: theme.textTheme.headlineMedium,),
   ),
  SizedBox( height: sizeHeight/10),
  ],
  ),
  ],
  ),
  )
  ]),
  
  TextfieldWidget(text: 'Username', hintIcon: Icons.person_outlined, controller: controllerName),
  
  SizedBox( height: sizeHeight/80),
  
  TextfieldWidget(text: 'Email Address', hintIcon: Icons.email_outlined, controller: controllerMail),
  
  SizedBox( height: sizeHeight/80),
  
Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [ 
Padding(
padding: const EdgeInsets.only(left: 12),
child: Text('Phone Number', style: Theme.of(context).textTheme.titleMedium),
),
InputPhoneNumber()]),  
  
SizedBox( height: sizeHeight/80),
  
TextfieldWidget(text: 'Password', hintIcon: Icons.lock_outline, controller: controllerPass),
  
SizedBox( height: sizeHeight/80),
    
TextfieldWidget(text: 'Confirm Password', hintIcon: Icons.lock_outline, controller: confirmPassController),
  
SizedBox( height: sizeHeight/80),
  

elevatedButton(sizeWidth, sizeHeight, signUp, isLoading == true? 'Signing in...' :'Sign Up' ),
  
 Padding(
    padding:  EdgeInsets.only(left: sizeWidth/4),
    child: Row( 
    children: [
    Text('Already have an account?'),
    TextButton(onPressed: (){
moveToNextScreen(context, Login());
    }, child: Text('Sign In', style: TextStyle(color: theme.primaryColor, fontSize: 16)))
    ],
    ),
  ),
  ],
  ),
),
);
}

// Email Sign Up
void signUp () async{
if (controllerPass.text == confirmPassController.text) {
setState(() {
  isLoading = true;
});
await FirebaseAuthMethods(FirebaseAuth.instance, context).signUpWithEmail(username: controllerName.text, email: controllerMail.text, phoneNumber: phoneNumber!.phoneNumber ?? '', password: controllerPass.text);
setState(() {
isLoading = false;
});
 } else {
showtextSnackbar(context, 'Your Passwords does not match.');
  }
  }
}