import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kineticx/API/fetchworkouts.dart';
import 'package:kineticx/Features/Step%20Counter/counter.dart';
import 'package:kineticx/Features/Water%20Tracker/water_intake_log.dart';
import 'package:kineticx/Helper/target_body_parts_filter.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Pages/Analytics/widgets/water_tracker.dart';
import 'package:kineticx/Pages/Home/Widgets/features_widget.dart';
import 'package:kineticx/Pages/Home/Widgets/heart_rate_data_widget.dart';
import 'package:kineticx/Pages/Home/Widgets/floatingactionbutton.dart';
import 'package:kineticx/Pages/Home/Widgets/stepcount_widget.dart';
import 'package:kineticx/Pages/Home/controllers/homecontroller.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/Widgets/shimmers.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/main.dart';
import 'package:kineticx/Pages/Popular%20Workouts%20Page/popular_workout_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
ref.read(HomeController.userName);
  getbodyPartFilter();
ExerciseDBApi().targetBodyPartList();  
}
DateTime? _lastPressedAt;

Future<void> printHistory() async {
  final prefs = await SharedPreferences.getInstance();
final history = prefs.getStringList('metricsHistory') ?? [];
  
for (var entry in history) {
  print('🕓 Historical Entry: $entry');
  }
}
  @override
  Widget build(BuildContext context) {

// Theme
final theme = Theme.of(context);

// Screen Size
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;

// State Management
final userNameAsyncValue = ref.watch(HomeController.userName);
final displayName =  userNameAsyncValue.when(data: (username){
if (username != null) {
return Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [ Text(getGreeting(),  style: theme.textTheme.headlineMedium,),
Text(username, style: theme.textTheme.headlineMedium!.copyWith(fontSize: sizeHeight/50, fontWeight: FontWeight.w900),),
  ],
) ; } else { return const Text('');
}
}, error:(error, _) => Text('Error: $error'),  loading: ()=>  usernameLoading(sizeHeight, sizeWidth)
);

final bodyPartListAsyncValue = ref.watch(HomeController.listBodyParts);


final stepCounts = ref.watch(stepCountProvider);
final maxStepCounts = ref.watch(maxStepsProvider).totalSteps;
final caloriesBurned = stepCounts * 0.04;
final waterIntake = ref.watch(analyticsProvider).cupsOfWater / 125;

// Metrics Calculation
final distance = stepCounts * 0.0008;

// Time
String currentTime = DateFormat('hh:mm a').format(DateTime.now());


return  WillPopScope( onWillPop: () async {
 final now = DateTime.now();

 if (_lastPressedAt == null || now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
   _lastPressedAt = now;
   showToast('Press back again to exit');
   return false;
 } else {
  SystemNavigator.pop();
   return true;
 } 
},


  child: Scaffold(
  body: Stack(
children: [ SingleChildScrollView( scrollDirection: Axis.vertical,
child: SafeArea(
child: Padding( padding:  EdgeInsets.only(left: sizeWidth/30),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [ 
displayName,
      
Spacer(),
      
IconButton( icon: Icon(Icons.notifications_none, size: 30), onPressed: (){}),
]),
      
SizedBox( height: sizeHeight/70),
        
Padding( padding: const EdgeInsets.all(10),
       
child: SizedBox( height: 45,
child: TextField( 
decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), 
filled: true, fillColor: theme.colorScheme.surfaceContainer, prefixIcon: Icon(Icons.search, size: 30),
contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), hintText: 'Search' , hintStyle: theme.textTheme.headlineMedium), 
),
),
) ,
        
        
Padding( padding:  EdgeInsets.only(bottom: sizeHeight/70, left: sizeHeight/70,  top:  sizeHeight/70),
child: Text('Popular Workouts', style: theme.textTheme.titleMedium,),
),
      
 bodyPartListAsyncValue.when(data: (parts) {
 return SizedBox( height: sizeHeight/3.8,
   child: ListView.builder(itemCount: parts.length, scrollDirection: Axis.horizontal, itemBuilder: (context, index) {
   final part = parts[index];
   return InkWell( onTap: () => moveToNextScreen(context, PopularWorkoutPage(bodyPart: part['bodyPart'], imageUrl: part['image'],)),
child: popularWorkoutsContainer(sizeHeight, sizeWidth, theme, part['bodyPart'], part['image']));
   }),
 );
 }, error: (err, stack) => Center(child: Text('Error: $err'),), loading: () => bodypartLoading(sizeHeight, sizeWidth)),
        
Padding(
padding: EdgeInsets.only(bottom: sizeHeight/70, left: sizeHeight/70, top:  sizeHeight/70),
child: Text('Today\'s Plan', style: theme.textTheme.titleMedium),
),
         
todayPlanContainer(sizeWidth, sizeHeight, theme,'Today\'s Plan', '100 Push up a day', 'Intermediate', (){}),
SizedBox( height: 15),
todayPlanContainer(sizeWidth, sizeHeight, theme,'Today\'s Plan', '100 Push up a day', 'Intermediate', (){}),
 SizedBox( height: 15),
todayPlanContainer(sizeWidth, sizeHeight, theme,'Today\'s Plan', '100 Push up a day', 'Intermediate', (){}),

SizedBox( height: sizeHeight/30,),

HeartRateDataWidget(),

SizedBox( height: sizeHeight/40),

waterIntake == 0 ?

FeaturesWidget(icon: FontAwesomeIcons.glassWater, title: 'Track Water Intake', subtitle: 'Track your water intake and stay hydrated always', iconColor: theme.primaryColor, iconBackgroundColor: theme.primaryColor.withValues(alpha: 0.3),
  elevatedButton: ElevatedButton(onPressed: (){

  moveToNextScreen(context, WaterIntakeLog()); 
  },  style: ElevatedButton.styleFrom( fixedSize: Size(sizeWidth/2.5, 50), backgroundColor: Colors.transparent.withValues(alpha: 0.1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)))
  ), 
  child: Text('Drink', style: theme.textTheme.titleMedium, ),
  )
  ):
 
 Stack(
children: [
WaterTracker(boxDecoration: BoxDecoration(
color: whiteColor, borderRadius: BorderRadius.all(Radius.elliptical(15, 15))
), sizeHeight: sizeHeight/4, sizeWidth: sizeWidth),
waterCount(sizeWidth, theme, sizeHeight, currentTime, context, waterIntake)
],
 )
  ,

SizedBox( height: sizeHeight/40),

stepCounts == 0  ?
FeaturesWidget(icon: FontAwesomeIcons.personWalking, title: 'Step Counter', subtitle: 'Take 10,000 steps a day to keep fit and healthy', iconColor: lilacPurple, iconBackgroundColor: lilacPurple.withValues(alpha: 0.3),
elevatedButton: ElevatedButton(onPressed: (){
ref.read(stepSessionProvider.notifier).startSession();
moveToNextScreen(context, Stepcounter()); },  style: ElevatedButton.styleFrom( fixedSize: Size(sizeWidth/2.5, 50), backgroundColor: lilacPurple.withValues(alpha: 0.7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)))
), 
child: Text('Let\'s Count', style: theme.textTheme.titleMedium, ),
)) :

StepCountWidget(sizeHeight: sizeHeight, sizeWidth: sizeWidth, theme: theme, stepCounts: stepCounts, maxStepCounts: maxStepCounts, distance: distance, caloriesBurned: caloriesBurned,),

SizedBox( height: sizeHeight/40),
],
),
),
),
),

Positioned( bottom: sizeHeight/9, right: sizeWidth/20,
child: FloatingactionbuttonWidget())
]),
  ),
);
}

Padding waterCount(double sizeWidth, ThemeData theme, double sizeHeight, String currentTime, BuildContext context, double waterIntake) {
return Padding( padding: EdgeInsets.only(left: sizeWidth/20, ),
child: Row(children: [
Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [ 
Text( currentTime, style: theme.textTheme.headlineMedium!.copyWith(fontSize: sizeHeight/45, fontWeight: FontWeight.w900),),
Text('${waterIntake.toInt()} cups of water', style: theme.textTheme.headlineMedium!.copyWith(color: steelGray),),
SizedBox( height: sizeHeight/20),

waterIntake < 8 ?
ElevatedButton(onPressed: (){
moveToNextScreen(context, WaterIntakeLog()); 
  },  style: ElevatedButton.styleFrom( fixedSize: Size(sizeWidth/3, 30), backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)))
  ), 
  child: Text('Drink', style: theme.textTheme.titleMedium!.copyWith(color: whiteColor, fontSize: 15, fontWeight: FontWeight.normal), ),
  ) 
  : 

  ElevatedButton(onPressed: (){
  },  style: ElevatedButton.styleFrom( fixedSize: Size(sizeWidth/3, 30), backgroundColor: Colors.black87.withValues(alpha: 0.1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)))
  ), 
  child: Text('Goal Reached', style: theme.textTheme.titleMedium!.copyWith(color: whiteColor, fontSize: 15, fontWeight: FontWeight.normal), ),
  )
  ],
),
SizedBox( width: sizeWidth/7),
Container( width: sizeWidth/2.5, height: sizeHeight/4, color: null, child: Image.asset(Images.cupofWater),)
],),
);
  }

SingleChildScrollView bodypartLoading(double sizeHeight, double sizeWidth) {
    return SingleChildScrollView( scrollDirection: Axis.horizontal,
child: Row(
children: [ ShimmerWidget(sizeHeight: sizeHeight/4, sizeWidth: sizeWidth/1.2),
SizedBox(width: 12),
ShimmerWidget(sizeHeight: sizeHeight/4, sizeWidth: sizeWidth/1.2),]
),
);
  }

Column usernameLoading(double sizeHeight, double sizeWidth) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
ShimmerWidget(sizeHeight: sizeHeight/35, sizeWidth: sizeWidth/4),
SizedBox(height: 2),
ShimmerWidget(sizeHeight: sizeHeight/35, sizeWidth: sizeWidth/4)
],);
  }

Widget todayPlanContainer(double sizeWidth, double sizeHeight, ThemeData theme, String title, String subtitle, String workoutLevel, VoidCallback navigate, ) {
return GestureDetector(onTap: navigate,
  child: Stack(
    children: [ Container( width: sizeWidth/1.05, height: sizeHeight/8,
    decoration: BoxDecoration( color: theme.colorScheme.surfaceContainer, borderRadius: BorderRadius.all(Radius.elliptical(20, 20)) ),
    child:  Row( spacing: 5,
    children: [
    Padding(
    padding:  EdgeInsets.all(12),
    child: Container( height: sizeHeight/7, width: sizeWidth/4.5,
    decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
    image:  DecorationImage(image: AssetImage(Images.todayPlan1), fit: BoxFit.cover)
    ),
    ),
    ),
    Padding( padding: EdgeInsets.all(3),
    child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text(title, style: theme.textTheme.headlineMedium),
    Text(subtitle, style:  theme.textTheme.bodySmall),
    Container( color: containerWhite,
    height: 20, width: sizeWidth/1.6,
    )
    ],
     ),
    ),
    ],
    ),
    ),
Positioned( right: 20,
  child: Container( width: sizeWidth/5, height: 20,
  decoration: BoxDecoration(color: theme.primaryColorDark, borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(5, 5))),
  child: Center(child: Text(workoutLevel, style: theme.textTheme.headlineSmall,)),),
)
  ]
  ),
);
  }

Widget popularWorkoutsContainer(double sizeHeight, double sizeWidth, ThemeData theme, String text, String bodyPartImage) {
    return Stack(
children: [ 
Padding( padding: EdgeInsets.only(right: sizeWidth/30),
  child: Container( height: sizeHeight/4, width: sizeWidth/1.2, 
  decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage(bodyPartImage), fit: BoxFit.cover),
  borderRadius: BorderRadius.all(Radius.elliptical(20, 20)), color: lilacPurple),
  ),
),
Positioned.fill( right: sizeWidth/6,
child: Container( 
decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.black.withValues(alpha: 0.0)]),
 borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),   ),
),
),

Row( 
children: [
Padding(
padding:  EdgeInsets.only( left: sizeWidth/16, right: sizeWidth/16, bottom: sizeHeight/50, top: sizeHeight/50),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox( width: sizeWidth/2.5,
child: Text('$text\nTraining', style: theme.textTheme.titleLarge, maxLines: 2,)),
SizedBox(height: sizeHeight/50),
labelContainer(sizeHeight, sizeWidth, Icons.water_drop_outlined, '500 Kcal', sizeWidth/4,),
SizedBox(height: sizeHeight/100),
labelContainer(sizeHeight, sizeWidth, Icons.alarm_add_outlined, '50 Min', sizeWidth/4.5,),
],
),
),
SizedBox(width: sizeWidth/2.5 - sizeWidth/4),
Icon(Icons.play_circle_fill, color: theme.primaryColor, size: 60) 
],
)
]
);
  }

Container labelContainer(double sizeHeight, double sizeWidth, IconData icon, String cal, double size) {
return Container(height: sizeHeight/25, width: size, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
color: Colors.white.withValues( alpha: 0.8),),
child: Row( mainAxisAlignment: MainAxisAlignment.center,
children: [
Padding(
  padding: const EdgeInsets.only(right: 5),
  child: Icon(icon),
), Text(cal)
],
));
  }

void showToast(String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

String getGreeting() {
  int hour = DateTime.now().hour;
  
  if (hour >= 5 && hour < 12) {
    return "Good Morning 🌞";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon ☀️";
  } else {
    return "Good Evening 🌙";
  }
}
}

