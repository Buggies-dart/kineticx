import 'package:flutter/material.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/Widgets/phone_number.dart';

void showSnackbar(
  BuildContext context, String text
){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Theme.of(context).colorScheme.onErrorContainer, content: Text(text, style: 
Theme.of(context).textTheme.bodyMedium),
elevation: 10, ));
}

void showdialogBox({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
  required TextEditingController phoneController,
  }
){
  showDialog(context: context, barrierDismissible: false,
  builder: (context)=> AlertDialog(title: const Text('Enter Your OTP Code'),
  content: Column( mainAxisSize: MainAxisSize.min,
children: [
Padding(
padding: const EdgeInsets.only(left: 12),
child: Text('Please Enter Your Phone Number', style: Theme.of(context).textTheme.titleMedium),
),
InputPhoneNumber(phoneController: phoneController, errorBorder: ''),
    ],
  ),
 actions: <Widget>[TextButton(onPressed: onPressed, child: const Text('Done'))], )
  );
}

void logOutOrDeleteAcct( BuildContext context , String action, String content, VoidCallback onTapYes){
showDialog(context: context, builder: (context)=> AlertDialog(
title: Text(action, style: Theme.of(context).textTheme.titleMedium,), content: Text(content), actions: [
TextButton(onPressed: onTapYes, child: Text('Proceed', style: Theme.of(context).textTheme.titleSmall)), TextButton(onPressed: (){
Navigator.pop(context);
}, child: Text('No', style: Theme.of(context).textTheme.titleSmall,) )
]
));
 }