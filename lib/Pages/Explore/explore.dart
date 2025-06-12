import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Features/Step%20Counter/counter.dart';
import 'package:kineticx/Features/Water%20Tracker/water_intake_log.dart';
import 'package:kineticx/Navigation/navigation.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/main.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {

final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return  PopScope(
canPop: false,
onPopInvoked: (didPop){
if (!didPop) {
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
return NavigationPage();
}), (route) => false);
}
},
  child: Scaffold(
  body: SingleChildScrollView( scrollDirection: Axis.vertical,
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SizedBox(height: sizeHeight/80),
  Padding(
  padding: const EdgeInsets.all(15),
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Stack(
  children: [ 
  Container( width: double.infinity, height: sizeHeight/4,
  decoration: BoxDecoration( image: DecorationImage(image: AssetImage(Images.analyticsHeader), fit: BoxFit.cover),
  borderRadius: BorderRadius.all(Radius.elliptical(25, 25))),
  ),
          
  Positioned.fill(
  child: Container(
  decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.elliptical(25, 25)), gradient: LinearGradient(colors: [
  Color(0xFF000000), Color(0x00000000)
  ]) ),
  ),
  ),
          
  Padding(
  padding:  EdgeInsets.all(sizeWidth/15),
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text('Best Quarantine\nWorkout', style: theme.textTheme.titleLarge),
  SizedBox( height: sizeHeight/15),
  Text('See More >>', style: theme.textTheme.titleSmall!.copyWith(color: theme.primaryColor))
  ],
  ),
  )
  ]
  ),
    
  SizedBox( height: sizeHeight/50),
        
  Text('Best for you', style: theme.textTheme.titleMedium),
  ],
  ),
    ),
      
    
  Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SizedBox( height: sizeHeight/3.2, width: double.infinity,
  child: ListView.builder( padding: EdgeInsets.only(top: 0, bottom: 0), itemCount: (4/2).ceil(),  physics: NeverScrollableScrollPhysics(), itemBuilder: (context, index){
  int firstIndex = index * 2;
  int secondIndex = firstIndex + 1;
  return Padding(
  padding: const EdgeInsets.only(left: 15, bottom: 10),
  child: SingleChildScrollView( scrollDirection: Axis.horizontal,
  child: Row(children: [
  workoutContainer(sizeWidth, sizeHeight, theme),
  workoutContainer(sizeWidth, sizeHeight, theme),
    ]),
    ),
    );       
  }),
  ),
  ],
  ),
    
  SizedBox( height: sizeHeight/50),
    
  Padding(
  padding: const EdgeInsets.only(left: 15),
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [ Text('Challenge', style: theme.textTheme.titleMedium),
  Padding(
  padding: const EdgeInsets.all(8.0),
  child: SingleChildScrollView( scrollDirection: Axis.horizontal,
    child: Row(
    children: [
  Consumer( builder: (context, ref, child) => challengeContainer(sizeHeight, sizeWidth, theme, '10K Steps\nEveryday', theme.primaryColor, Images.oneKsteps, textColorBlack, (){
  ref.read(stepSessionProvider.notifier).startSession();
  moveToNextScreen(context, Stepcounter());
      }),
    ),
    SizedBox(width: sizeWidth/30),
  
  challengeContainer(sizeHeight, sizeWidth, theme, '8 Cups of\n Water Daily', textColorBlack, Images.cupsofwater, theme.colorScheme.surfaceContainer, (){
    moveToNextScreen(context, WaterIntakeLog());
  }),
  
  SizedBox(width: sizeWidth/30),
  
  challengeContainer(sizeHeight, sizeWidth, theme, 'Sprint\nChallenge', theme.colorScheme.surfaceContainer, Images.sprint, textColorBlack, (){
  showComingSoonDialog(context);
  }),
    ],
    ),
  ),
  )
  ]),
  ),
    
    SizedBox( height: sizeHeight/50),
    
    Padding(
    padding: const EdgeInsets.all(15),
    child: Text('Fast Warmup', style: theme.textTheme.titleMedium),
    ),
    
    Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox( height: sizeHeight/3.5, width: double.infinity,
    child: ListView.builder( padding: EdgeInsets.only(top: 0, bottom: 0), itemCount: (4/2).ceil(),  physics: NeverScrollableScrollPhysics(), itemBuilder: (context, index){
    int firstIndex = index * 2;
    int secondIndex = firstIndex + 1;
    return Padding(
    padding: const EdgeInsets.only(left: 15, bottom: 10),
    child: SingleChildScrollView( scrollDirection: Axis.horizontal,
    child: Row(children: [
    workoutContainer(sizeWidth, sizeHeight, theme),
    workoutContainer(sizeWidth, sizeHeight, theme),
    ]),
    ),
    );
         
    }),
    ),
    ],
    ),
      ],
      ),
  ),
      ),
);
  }

Widget challengeContainer(double sizeHeight, double sizeWidth, ThemeData theme, String text, Color containerColor, String img, Color textColor, VoidCallback onTap) {
return InkWell( onTap: onTap,
  child: Container( height: sizeHeight/6, width: sizeWidth/3.5,
  decoration: BoxDecoration( image: DecorationImage(image: AssetImage(img), fit: BoxFit.contain),
  color: containerColor, borderRadius: BorderRadius.all(Radius.elliptical(10, 10))
      ),
      child: Center(child: Text(text, style: theme.textTheme.titleMedium!.copyWith(color: textColor, fontWeight: FontWeight.w600),)),),
);
  }

  Widget workoutContainer(double sizeWidth, double sizeHeight, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(  width: sizeWidth/1.5, height: sizeHeight/7,
      decoration: BoxDecoration( color: theme.colorScheme.surfaceContainer, borderRadius: BorderRadius.all(Radius.elliptical(15, 15)) ),
      child: Row(
      children: [
      Padding(
      padding:  EdgeInsets.all(sizeHeight/90),
      child: Container( width: sizeWidth/4, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
      image: DecorationImage(image: AssetImage(Images.bellyfat), fit: BoxFit.cover) ),
      ),
      ),
      Padding(
      padding: const EdgeInsets.only( left:  5, top: 5),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text('Belly fat burner', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 18),),
      chipContainer(theme, '10 mins'),
      chipContainer(theme, 'Beginner')
      ],
      ),
      )
      ],
      ),
      ),
    );
  }

Widget chipContainer(ThemeData theme, String text) {
return SizedBox( height: 40,
  child: Chip( side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide.none),
  backgroundColor: theme.colorScheme.tertiaryContainer, label: Text(text, style: theme.textTheme.labelSmall,)),
);
  }

void showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_empty_rounded, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This feature is currently under development. Stay tuned for updates!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Okay',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}