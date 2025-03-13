import 'package:flutter/material.dart';
import 'package:kineticx/Pages/Onboarding%20screens/Widgets/phone_number.dart';

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
  required VoidCallback onPressed}
){
  showDialog(context: context, barrierDismissible: false,
  builder: (context)=> AlertDialog(title: const Text('Enter Your OTP Code'),
  content: Column( mainAxisSize: MainAxisSize.min,
children: [
Padding(
padding: const EdgeInsets.only(left: 12),
child: Text('Please Enter Your Phone Number', style: Theme.of(context).textTheme.titleMedium),
),
InputPhoneNumber()
    ],
  ),
 actions: <Widget>[TextButton(onPressed: onPressed, child: const Text('Done'))], )
  );
}