import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:kineticx/Features/Heart%20Rate%20Measure/Widgets/heart_clipper.dart';
import 'package:kineticx/Features/Heart%20Rate%20Measure/Widgets/loading_indicator.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/main.dart';

class HeartRateMonitor extends ConsumerStatefulWidget {
  const HeartRateMonitor({super.key});

  @override
  ConsumerState<HeartRateMonitor> createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends ConsumerState<HeartRateMonitor> {
  
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isProcessing = false;
  bool _isMeasuring = false;
  bool isFingerDetected = false;
  List<int> intensityValues = [];
  int _bpm = 0;
  Timer? _timer;

  @override
  void initState() {
super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _resetAndStartCamera();
  });
  }


Future<void> _resetAndStartCamera() async {
  // Dispose existing controller
  if (_cameraController != null) {
    await _cameraController!.dispose();
    _cameraController = null;
  }

  final controller = await _initializeCamera();
  if (controller == null || !mounted) return;

  _cameraController = controller;

  await _cameraController!.setFlashMode(FlashMode.torch);

  setState(() {
    _isMeasuring = false;
    _isProcessing = false;
    intensityValues.clear();
    isFingerDetected = false;
  });

  _startMeasuring();
}

Future<CameraController?> _initializeCamera() async {
  try {
    _cameras = await availableCameras();
    final controller = CameraController(_cameras!.first, ResolutionPreset.low);
    await controller.initialize();
    return controller;
  } catch (e) {
    debugPrint("Camera initialization error: $e");
    return null;
  }
}


void _startMeasuring() {
  if (_isMeasuring) return;

  setState(() {
    _isMeasuring = true;
    isFingerDetected = false;
    intensityValues.clear();
  });

  _cameraController!.setFlashMode(FlashMode.torch); // Turn on Flash

 _timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
  if (!_isMeasuring || _isProcessing || !mounted) return;

_isProcessing = true; // Lock processing

try {
XFile image = await _cameraController!.takePicture();
Uint8List bytes = await image.readAsBytes();
img.Image? decodedImage = img.decodeImage(bytes);

if (decodedImage != null) {
int totalRed = 0;
for (int y = 0; y < decodedImage.height; y++) {
for (int x = 0; x < decodedImage.width; x++) {
var pixel = decodedImage.getPixel(x, y);
totalRed += pixel.r.toInt(); // Get red intensity
}
}

int avgRed = (totalRed ~/ (decodedImage.width * decodedImage.height)).toInt();

if (avgRed > 160) { 
setState(() {
isFingerDetected = true;
});
intensityValues.add(avgRed);
ref.read(analyticsProvider.notifier).heartRateData(intensityValues);
 _calculateBPM();

} else {
setState(() {
isFingerDetected = false;
_bpm = 0;
intensityValues.clear();
});
          
}
}
} catch (e) {
print("Error capturing image: $e");
}

_isProcessing = false; // Unlock processing
  });
}

void _calculateBPM() {
int peaks = 0;
for (int i = 1; i < intensityValues.length - 1; i++) {
if (intensityValues[i] > intensityValues[i - 1] &&
intensityValues[i] > intensityValues[i + 1]) {
peaks++;
}
}
_bpm = peaks * 6;
ref.read(analyticsProvider.notifier).bpmData(_bpm);
setState(() {});
}

void _stopMeasuring() {
  _isMeasuring = false;
  _timer?.cancel();
  _cameraController?.setFlashMode(FlashMode.off);
}

  @override
void dispose() {
   _stopMeasuring();
_timer?.cancel();
super.dispose();
  }



@override
Widget build(BuildContext context) {
final theme = Theme.of(context);
final sizeWidth = MediaQuery.of(context).size.width;
final sizeHeight = MediaQuery.of(context).size.height;
return Scaffold( backgroundColor: theme.primaryColorDark,
appBar: AppBar( leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.surfaceContainer)), centerTitle: true,
title: Text("Heart Rate Monitor", style: theme.textTheme.titleMedium!.copyWith( color: Colors.white),), backgroundColor: theme.primaryColorDark, actions: [
IconButton(onPressed: (){}, icon: Icon(Icons.notifications, size: 25, color: theme.colorScheme.surfaceContainer,))
]),
body: Center(
child: Column( 
  children: [
  _cameraController != null && _cameraController!.value.isInitialized
  ?
  
Stack(
children: [ 
  FittedBox( fit: BoxFit.contain,
child: Stack(
  children: [ 
Positioned( bottom: 0.5, top: 2, right: 0.2, left: 0.2,
child:  AnimatedHeartClipper(detectFinger: isFingerDetected,) ),
ClipPath( clipper: HeartClipper(),
child: Container( width: sizeWidth * 0.75, height: sizeHeight * 0.4, color: null,
child: CameraPreview(_cameraController!))),
]),
  ),
  Positioned( top: sizeHeight/5.5, left: sizeWidth/4,
child: Text(
"BPM: $_bpm",
style: theme.textTheme.titleLarge!.copyWith(fontSize: 25),
),
  ),
  ]) : SizedBox.shrink(),
  
  
isFingerDetected == false && _bpm < 1
? Container(
width: sizeWidth,
height: sizeHeight / 25,
color: Colors.red,
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.fingerprint, color: whiteColor),
Text(
'No finger detected',
 style: theme.textTheme.bodyMedium!.copyWith(color: whiteColor),
 ),
],
),
) :
 _bpm < 1 ?
Center(
child: Text(
'Waiting for the reading to stabilize...',
style: theme.textTheme.bodyMedium!.copyWith(color: whiteColor),
),
) : LoadingIndicator(stopMeasuring: _stopMeasuring),


 SizedBox( height: sizeHeight/10),
Padding(
  padding: const EdgeInsets.all(10),
  child: Container( width: sizeWidth, height: sizeHeight/3,
  decoration: BoxDecoration( borderRadius: BorderRadius.circular(15),
  color: darkSlateGray
  ),
  child: Padding(
padding: const EdgeInsets.all(10),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cover the camera with your finger until ❤️ turns red', style: theme.textTheme.bodyMedium!.copyWith(color: whiteColor, fontWeight: FontWeight.bold)),
Padding(
  padding: const EdgeInsets.only(top: 10),
  child: Container( height: sizeHeight/4.2, width: sizeWidth, 
  decoration: BoxDecoration(  borderRadius: BorderRadius.circular(15), color: theme.colorScheme.onPrimaryFixedVariant, image: DecorationImage(image: AssetImage(Images.fingerDetection), fit: BoxFit.contain)
  ),
  ),
)
],
    ),
  ),
    ),
)
  ],
  ),
),
);
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