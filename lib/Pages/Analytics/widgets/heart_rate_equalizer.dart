import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/main.dart';

class HeartRateEqualizer extends ConsumerStatefulWidget {
  const HeartRateEqualizer({super.key});
  @override
  ConsumerState<HeartRateEqualizer> createState() => _HeartRateEqualizerState();
}

class _HeartRateEqualizerState extends ConsumerState<HeartRateEqualizer>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
  super.initState();
controller = AnimationController(
vsync: this,
duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
final heartRateData = ref.watch(analyticsProvider).heartRateData.toSet().toList();
print(heartRateData);
return Padding(
padding: const EdgeInsets.all(8.0),
child: SizedBox(
height: 50,
child: AnimatedBuilder(
animation: controller!,
builder: (context, child) {
return Row( mainAxisAlignment: MainAxisAlignment.center,
children: List.generate(heartRateData.length, (index) {
double heightVariation = (controller!.value * 40);
double barHeight = ((heartRateData[index] / 4) - heightVariation).clamp(5, 30).toDouble();

return AnimatedContainer( duration: const Duration(milliseconds: 200), width: 2, height: barHeight,
margin: const EdgeInsets.symmetric(horizontal: 2), color: Colors.red,
curve: Curves.easeOut,
);
}),
);
 },
),
),
);
  }
}
