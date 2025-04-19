import 'package:flutter/material.dart';

class AnimatedHeartClipper extends StatefulWidget {
  const AnimatedHeartClipper({super.key, required this.detectFinger});
 final bool detectFinger;
  @override
  State<AnimatedHeartClipper> createState() => _AnimatedHeartClipperState();
}

class _AnimatedHeartClipperState extends State<AnimatedHeartClipper> with SingleTickerProviderStateMixin{

 late AnimationController _controller;
  late Animation<double> _animation;
   late Animation<double> _opacityAnimation;

 @override
  void initState() {
super.initState();
_controller = AnimationController(
vsync: this,
duration: Duration(seconds: 1),
)..repeat(reverse: true);

_animation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
parent: _controller,
curve: Curves.easeInOut,
));

 _opacityAnimation = Tween<double>(begin: 0.4, end: 0.0).animate(CurvedAnimation(
parent: _controller,
curve: Curves.easeInOut,));
  }

  @override
  void dispose() {
_controller.dispose();
super.dispose();
  }
 
@override
Widget build(BuildContext context) {
final sizeWidth = MediaQuery.of(context).size.width;
final sizeHeight = MediaQuery.of(context).size.height;


return widget.detectFinger == false ? Container(color: null) : AnimatedBuilder(animation: _animation, builder: (context, child){

return Opacity( opacity: _opacityAnimation.value,
  child: Transform.scale( scale: _animation.value,
  child: ClipPath(clipper: HeartClipper(),
  child: Container( width: sizeWidth * 0.8, height: sizeHeight * 0.5, color: Colors.red.withValues(alpha: 2),
  )
  )),
);
}); 
  }
}

class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
final path = Path();
double width = size.width;
double height = size.height;

path.moveTo(width / 2, height * 0.8);
path.cubicTo(width * 1.2, height * 0.4, width * 0.8, 0, width / 2, height * 0.3);
path.cubicTo(width * 0.2, 0, -0.2 * width, height * 0.4, width / 2, height * 0.8);
path.close();

return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}