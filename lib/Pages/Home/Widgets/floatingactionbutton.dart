import 'package:flutter/material.dart';
import 'package:kineticx/Utils/components.dart';

class FloatingactionbuttonWidget extends StatefulWidget {
  const FloatingactionbuttonWidget({super.key});

  @override
  State<FloatingactionbuttonWidget> createState() => FloatingactionbuttonWidgetState();
}

class FloatingactionbuttonWidgetState extends State<FloatingactionbuttonWidget> with SingleTickerProviderStateMixin {

late AnimationController? _controller;
late Animation<double>? _animation;

@override
  void initState() {
    super.initState();
_controller = AnimationController(vsync: this, duration: Duration(seconds: 1),
lowerBound: 0.8, upperBound: 1.2)..repeat(reverse: true);
 _animation = Tween<double>(begin: 1, end: 1.2).animate(_controller!);
  }

  @override
  Widget build(BuildContext context) {
return  Material( elevation: 60, shadowColor: Colors.black, color: Colors.transparent,
  child: ScaleTransition( scale: _animation!,
    child: FloatingActionButton(onPressed: (){},  backgroundColor: lilacPurple, 
    shape: CircleBorder(),
    child: Image.asset('assets/images/chatbot2.png', height: 35, width: 30, color: whiteColor)),
  ),
);
  }

  @override
  void dispose() {
 _controller?.dispose();
    super.dispose();
  }
}