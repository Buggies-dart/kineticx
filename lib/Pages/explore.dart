import 'package:flutter/material.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/components.dart';

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

return  Scaffold(
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
  challengeContainer(sizeHeight, sizeWidth, theme, '1000 Steps\nEveryday', theme.primaryColor, Images.oneKsteps, textColorBlack),
  SizedBox(width: sizeWidth/30),
  challengeContainer(sizeHeight, sizeWidth, theme, '8 Cups of\n Water Daily', textColorBlack, Images.cupsofwater, theme.colorScheme.surfaceContainer),
  SizedBox(width: sizeWidth/30),
  challengeContainer(sizeHeight, sizeWidth, theme, 'Sprint\nChallenge', theme.colorScheme.surfaceContainer, Images.sprint, textColorBlack),
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
    );
  }

Widget challengeContainer(double sizeHeight, double sizeWidth, ThemeData theme, String text, Color containerColor, String img, Color textColor) {
return Container( height: sizeHeight/6, width: sizeWidth/3.5,
decoration: BoxDecoration( image: DecorationImage(image: AssetImage(img), fit: BoxFit.contain),
color: containerColor, borderRadius: BorderRadius.all(Radius.elliptical(10, 10))
),
child: Center(child: Text(text, style: theme.textTheme.titleMedium!.copyWith(color: textColor, fontWeight: FontWeight.w600),)),);
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
}