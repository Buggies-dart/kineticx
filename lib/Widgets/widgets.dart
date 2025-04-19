import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Utils/components.dart';

// Onboarding Progress Bar
Container progressBarOnboarding(double sizeHeight, double sizeWidth, ThemeData theme, int num) {
return Container( height: sizeHeight/170, width: sizeWidth/5, decoration: BoxDecoration(
color: theme.primaryColorDark, borderRadius: BorderRadius.circular(30)
),
child: Row(children: [
Expanded( flex: num, child: Container(
decoration: BoxDecoration(
color: theme.primaryColor, borderRadius: BorderRadius.circular(30)
),
)),
Expanded( flex: 2, child: Container(
decoration: BoxDecoration(
color: theme.primaryColorDark, borderRadius: BorderRadius.circular(30)
),
)
),
],)
);
  }

// Launch Screen, Get Started Button
Widget elevatedButton(double sizeWidth,  double sizeHeight,  onTap, String text) {
return Consumer( builder: (context, ref, child) => 
 SizedBox( width: sizeWidth/1, height: sizeHeight/11,
child: Padding( 
padding: const EdgeInsets.all(12),
child: ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom( backgroundColor: textColorBlack,
shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30))),
child: Text(text, style: TextStyle(fontSize: 16, color: whiteColor))
),
  ),
  ),
);
  }
// Arrowback Icon

IconButton arrowBackIcon(BuildContext context) {
return IconButton(onPressed: (){
Navigator.pop(context);
}, icon: Icon(Icons.arrow_back_ios_new_sharp, size: 30),);
  }

// SnackBar779

void showtextSnackbar(
BuildContext context, String text
){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Theme.of(context).colorScheme.onErrorContainer, content: Text(text, style: 
Theme.of(context).textTheme.bodyMedium),
elevation: 10, ));
}

void showProgressSnackBar(BuildContext context, String text){
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
content: Text(
text,
style: TextStyle(fontSize: 16),
),
backgroundColor: Colors.blueAccent,
behavior: SnackBarBehavior.floating,
shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: Duration(seconds: 4),
  ),
);
}