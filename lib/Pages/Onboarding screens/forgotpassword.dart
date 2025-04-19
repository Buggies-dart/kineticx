import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return Scaffold(
backgroundColor: whiteColor,
body: SafeArea(
child: Column( 
children: [
Padding(
padding:  EdgeInsets.only(left: 10),
child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [ arrowBackIcon(context)
  ],
  ),
),

Align( alignment: Alignment.centerLeft,
child: Padding(
padding:  EdgeInsets.only( left: sizeWidth/20, top: sizeHeight/50), 
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Reset Password', style: theme.textTheme.displayLarge),
SizedBox( height: 8),
Text('Choose how you would like to reset your password', style: theme.textTheme.headlineMedium)
],
),
)),

SizedBox( height: sizeHeight/20),

Column(
  children: [
resetPasswordOptions(sizeHeight, sizeWidth, theme, 'Send via Email', 'Seamlessly reset your\npassword via email address',
MdiIcons.email, yellowOrange),
SizedBox( height: sizeHeight/80),
resetPasswordOptions(sizeHeight, sizeWidth, theme, 'Send via 2FA', 'Seamlessly reset your\npassword via 2-Factor Auth',
Icons.lock, theme.primaryColor),
SizedBox( height: sizeHeight/80),
resetPasswordOptions(sizeHeight, sizeWidth, theme, 'Send via Google Auth', 'Seamlessly reset your\npassword via gAuth',
MdiIcons.googleCloud, lilacPurple),
],
),

SizedBox( height: sizeHeight/20),

elevatedButton(sizeWidth, sizeHeight, (){}, 'Reset Password')
],
),
),
);
}


Container resetPasswordOptions(double sizeHeight, double sizeWidth, ThemeData theme, String text, String body, IconData icon,
Color color) {

return Container( height: sizeHeight/10, width: sizeWidth/1.05, decoration: BoxDecoration(
borderRadius: BorderRadius.vertical(top: Radius.elliptical(20, 20), bottom: Radius.elliptical(25, 25),),
color: scaffold ),
child: Padding(
padding:  EdgeInsets.only(left: sizeWidth/25,),
child: Row(
children: [
Container(  height: sizeHeight/15,  width: sizeWidth/6.5, decoration: BoxDecoration(
borderRadius: BorderRadius.horizontal(left: Radius.elliptical(20, 20), right: Radius.elliptical(20, 20)),
color: color),
child: Icon(icon, size: 30, color: whiteColor,),
 ),

Padding(
padding: EdgeInsets.only( left: 6, top: 6),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(text, style: theme.textTheme.titleMedium,),
Text(body, style: theme.textTheme.headlineMedium )
],
  ),
),

Padding( padding: EdgeInsets.only(left: text == 'Send via Email' ||  text == 'Send via 2FA'? sizeWidth/6.5 : sizeWidth/5),
child: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: theme.colorScheme.onPrimaryContainer,)) ],
),
),
);
  }
}