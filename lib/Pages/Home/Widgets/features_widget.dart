import 'package:flutter/material.dart';

class FeaturesWidget extends StatelessWidget {
  const FeaturesWidget({
super.key, required this.icon, required this.title, required this.subtitle,
required this.elevatedButton, required this.iconColor, required this.iconBackgroundColor,
  });

final IconData icon;
final String title;
final String subtitle;
final Widget elevatedButton;
final Color iconColor;
final Color iconBackgroundColor;
  @override
  Widget build(BuildContext context) {

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

// Theme
final theme = Theme.of(context);

return Container(
height: sizeHeight/4.3, width: sizeWidth,
decoration: BoxDecoration( color: theme.colorScheme.surfaceContainer, borderRadius: BorderRadius.all(Radius.elliptical(20, 20)) ),
child: Column(
children: [
Row(
children: [
SizedBox( width: sizeWidth/1.05,
child: ListTile( contentPadding: EdgeInsets.only(left: 20, right: 1),
leading: CircleAvatar( backgroundColor: iconBackgroundColor, child: Icon(icon, color: iconColor,)), 
title: Text(title, style: theme.textTheme.headlineMedium!.copyWith(fontSize: 20)),
trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios, size: 15)),
),
)
],
),
SizedBox( height: sizeHeight/100),
Padding(
padding: const EdgeInsets.only(left: 8),
child: Text(subtitle, style: theme.textTheme.bodySmall!.copyWith(fontSize: 18),),
),
elevatedButton
],
),
);
  }
}
