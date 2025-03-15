import 'package:flutter/material.dart';
import 'package:kineticx/components.dart';

class FloatingactionbuttonWidget extends StatefulWidget {
  const FloatingactionbuttonWidget({super.key});

  @override
  State<FloatingactionbuttonWidget> createState() => FloatingactionbuttonWidgetState();
}

class FloatingactionbuttonWidgetState extends State<FloatingactionbuttonWidget> {
  @override
  Widget build(BuildContext context) {
return  Material( elevation: 60, shadowColor: Colors.black, color: Colors.transparent,
  child: Column(
  children: [
  Text('AI Chat', style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColorDark),),  
  FloatingActionButton(onPressed: (){},  backgroundColor: lilacPurple, 
  shape: CircleBorder(),
child: Image.asset('assets/images/chatbot2.png', height: 35, width: 30, color: whiteColor))],
  ),
);
  }
}