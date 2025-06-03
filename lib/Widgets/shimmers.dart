import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.sizeHeight,
    required this.sizeWidth,
  });

  final double sizeHeight;
  final double sizeWidth;
  
  @override
  Widget build(BuildContext context) {
return Shimmer.fromColors( baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
child: Container( height: sizeHeight, width: sizeWidth, 
decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
color: Colors.red),
),
    );
  }
}
