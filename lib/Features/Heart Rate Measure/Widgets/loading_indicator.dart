import 'dart:async';

import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key, required this.stopMeasuring});
final VoidCallback stopMeasuring;
  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {

double _progress = 0.0;
Timer? _timer;
@override
  void initState() {
    super.initState();
_startProgress();
  }

void _startProgress() {
_timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
if (!mounted) return;  
if (_progress < 1.0) {
setState(() {
_progress += 0.01;
});
} else {
_timer?.cancel();
widget.stopMeasuring(); 
}
});
}

@override
void dispose() {
_timer!.cancel(); 
super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 return  SizedBox( width: MediaQuery.of(context).size.width/1.5,
   child: LinearProgressIndicator( borderRadius: BorderRadius.circular(10),
   value: _progress,
   minHeight: 10,
   backgroundColor: Colors.grey[300],
   valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
   ),
 );
  }
}

