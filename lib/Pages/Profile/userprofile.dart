import 'package:flutter/material.dart';
import 'package:kineticx/Pages/Profile/Widgets/userAvatar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
final theme = Theme.of(context);
return Scaffold(
body:  SingleChildScrollView( scrollDirection: Axis.vertical,
  child: SafeArea( 
  child: Column(
    children: [ 
  UserAvatar(),
  SizedBox(height: 30),
  
  profileAction(theme, Icons.monitor_heart, 'Health Details', Icons.arrow_forward_ios, (){}),
  profileAction(theme, Icons.monitor_heart, 'Health Details', Icons.arrow_forward_ios, (){}),
  profileAction(theme, Icons.monitor_heart, 'Health Details', Icons.arrow_forward_ios, (){}),
  profileAction(theme, Icons.notifications, 'Notifications', Icons.arrow_forward_ios, (){}),
  profileAction(theme, Icons.settings_accessibility, 'Accessibility Settings', Icons.arrow_forward_ios, (){}),
  
  ]
  
  ),
  ),
)
);
  }

Padding profileAction(ThemeData theme, IconData leading, String title, IconData trailing, VoidCallback ontap) {
return Padding(
padding: const EdgeInsets.all(15),
child: ListTile( onTap: ontap, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), visualDensity: VisualDensity(vertical: 4)
,leading: Padding(
  padding: const EdgeInsets.only(left: 5),
  child: Icon(leading, color: theme.primaryColorDark, size: 30),
), contentPadding: EdgeInsets.zero,
title: Text(title, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),),
trailing: Icon(trailing), tileColor: theme.colorScheme.surfaceContainer,),
);
  }

}

