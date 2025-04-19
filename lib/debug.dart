import 'package:flutter/material.dart';

class HeartAnimationScreen extends StatefulWidget {
  const HeartAnimationScreen({super.key});
  @override
  State<HeartAnimationScreen> createState() => _HeartAnimationScreenState();
}
class _HeartAnimationScreenState extends State<HeartAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0.6, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated Glow Effect
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red.withOpacity(0.8),
                      size: 180, // Bigger for the glow
                    ),
                  ),
                );
              },
            ),

            // Static Heart Icon (Main Heart)
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 150,
            ),
          ],
        ),
      ),
    );
  }
}