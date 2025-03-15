import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Pages/Home/Widgets/floatingactionbutton.dart';
import 'package:kineticx/Pages/Home/controllers/homecontroller.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/components.dart';
import 'package:shimmer/shimmer.dart';

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
  }

DateTime? _lastPressedAt;

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
return Text(username, style: theme.textTheme.displayLarge) ; } else { return const Text('');
}
}, error:(error, _) => Text('Error: $error'),  loading: ()=> const Text('')
);

final bodyPartListAsyncValue = ref.watch(HomeController.bodyPartList);

final bodyParts = bodyPartListAsyncValue.when(data: (parts) {
return SizedBox( height: sizeHeight/3.8,
  child: ListView.builder(itemCount: parts.length, scrollDirection: Axis.horizontal, itemBuilder: (context, index) {
  final part = parts[index];
  return popularWorkoutsContainer(sizeHeight, sizeWidth, theme, part['bodyPart'], part['image']);
  }),
);
}, error: (err, stack) => Center(child: Text('Error: $err'),), loading: () => Shimmer.fromColors( baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
  child: SingleChildScrollView( scrollDirection: Axis.horizontal,
child: Row(
children: [ 
Container( height: sizeHeight/4, width: sizeWidth/1.2, 
decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
color: Colors.red),
),
SizedBox( width: sizeWidth/30),
Container( height: sizeHeight/4, width: sizeWidth/1.2, 
decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
 color: Colors.red),
      ),
    ]),
  ),
));




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
    Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good Morning!',  style: theme.textTheme.headlineMedium,),
        displayName,
      ],
      ),
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
      
        bodyParts,
        
        Padding(
        padding: EdgeInsets.only(bottom: sizeHeight/70, left: sizeHeight/70, top:  sizeHeight/70),
          child: Text('Today\'s Plan', style: theme.textTheme.titleMedium),
        ),
         
        todayPlanContainer(sizeWidth, sizeHeight, theme,'Today\'s Plan', '100 Push up a day', 'Intermediate', (){}),
        SizedBox( height: 15),
        todayPlanContainer(sizeWidth, sizeHeight, theme,'Today\'s Plan', '100 Push up a day', 'Intermediate', (){}),
          SizedBox( height: 15),
        todayPlanContainer(sizeWidth, sizeHeight, theme,'Today\'s Plan', '100 Push up a day', 'Intermediate', (){}),
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
padding:  EdgeInsets.all(sizeWidth/16),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox( width: sizeWidth/2.5,
child: Text('$text\nTraining', style: theme.textTheme.titleLarge,)),
SizedBox(height: sizeHeight/50),
labelContainer(sizeHeight, sizeWidth, Icons.water_drop_outlined, '500 Kcal', sizeWidth/4,),
SizedBox(height: sizeHeight/50),
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
}