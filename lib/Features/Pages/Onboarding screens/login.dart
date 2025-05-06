import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kineticx/Firebase/firebase_auth.dart';
import 'package:kineticx/Firebase/firebase_widgets.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/forgotpassword.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/signup.dart';
import 'package:kineticx/Widgets/textfield.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
bool isloading = false;
bool isValueEmpty = false;
final TextEditingController controllerMail = TextEditingController();
final TextEditingController controllerPass = TextEditingController();
final TextEditingController controllerPhone = TextEditingController();
@override
  void dispose() {
    super.dispose();
  controllerMail; controllerPass;
  }
  @override
Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);
return  Scaffold( backgroundColor: whiteColor,
body: SingleChildScrollView( scrollDirection: Axis.vertical,
  
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
  Text('Login To Kineticx', style: theme.textTheme.displayLarge),
      
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
  
  TextfieldWidget(text: 'Email Address', hintIcon: Icons.email_outlined, controller: controllerMail,errorBorder: isValueEmpty == true ? OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.red, width: 2)) :
  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
  errorText: isValueEmpty == true && controllerMail.text.isEmpty ? '*This field cannot be empty' : ''),
  
  SizedBox( height: sizeHeight/50),
  
  TextfieldWidget(text: 'Password', hintIcon: Icons.lock_outline, controller: controllerPass, errorBorder: isValueEmpty == true ? OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.red, width: 2)) :
  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
  errorText: isValueEmpty == true && controllerPass.text.isEmpty ? '*This field cannot be empty' : ''),
  
  SizedBox( height: sizeHeight/50),
  
  elevatedButton(sizeWidth, sizeHeight, signinWithEmailandPassword,  isloading == true? 'Signing in...' : 'Sign In'),
  
  Padding(
    padding:  EdgeInsets.only(top: 8, left: sizeWidth/4),
    child: Row(
    children: [
    socialLogin(sizeHeight, sizeWidth, FontAwesomeIcons.google, (){
FirebaseAuthMethods(FirebaseAuth.instance, context).signinWithGoogle();
    }),
    SizedBox( width: 12),
    socialLogin(sizeHeight, sizeWidth, FontAwesomeIcons.facebook, (){}),
    SizedBox( width: 12),
    socialLogin(sizeHeight, sizeWidth, MdiIcons.phone, (){
showdialogBox(context: context, codeController: controllerPhone, onPressed: (){
FirebaseAuthMethods(FirebaseAuth.instance, context).phoneSigning(controllerPhone.text);
}, phoneController: controllerPhone);
    }),

    ],
    ),
  ),
  
  Padding(
    padding:  EdgeInsets.only(left: sizeWidth/4),
    child: Row( 
    children: [
    Text('Don\'t have an account?'),
    TextButton(onPressed: (){
 moveToNextScreen(context, SignUp());
    }, child: Text('Sign Up', style: TextStyle(color: theme.primaryColor, fontSize: 16), ))
    ],
    ),
  ),
  TextButton(onPressed: (){
  Navigator.push(context, MaterialPageRoute(builder: (context){
  return Forgotpassword();
  }));
  }, child: Text('Forgot Password', style: TextStyle(color: theme.primaryColor, fontSize: 16),))
  ],
  ),
),
);
  }

GestureDetector socialLogin(double sizeHeight, double sizeWidth, IconData icon, VoidCallback authSignIn) {
return GestureDetector( onTap: authSignIn,
child: Container( height: sizeHeight/15.5, width: sizeWidth/6.8,
decoration: BoxDecoration(
color: Colors.transparent, borderRadius: BorderRadius.vertical(top: Radius.elliptical(20, 20), bottom: Radius.elliptical(20, 20) ), border: Border.all(width: 0.5)
),
child: Icon(icon),
),
);
  }

void signinWithEmailandPassword() async{
setState(() {
isValueEmpty = controllerMail.text.isEmpty || controllerPass.text.isEmpty;
});
if (!isValueEmpty) {
setState(() {
isloading = true;
});
await FirebaseAuthMethods(FirebaseAuth.instance, context).userSignin(mail: controllerMail.text, password: controllerPass.text);
setState(() {
isloading = false;
});
}
}
}