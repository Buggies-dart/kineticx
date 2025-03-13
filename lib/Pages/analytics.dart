import 'package:flutter/material.dart';
import 'package:kineticx/Utils/pngs.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return  Scaffold(
body: Column(
children: [
Container( width: double.infinity, height: sizeHeight/5,
decoration: BoxDecoration( image: DecorationImage(image: AssetImage(Images.analyticsHeader), fit: BoxFit.cover) ),
)
],
),
    );
  }
}