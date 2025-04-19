import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Pages/Onboarding%20screens/Assessments/setweight.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/main.dart';

class Setgender extends ConsumerStatefulWidget {
  const Setgender({super.key});

  @override
  ConsumerState<Setgender> createState() => _SetgenderState();
}

class _SetgenderState extends ConsumerState<Setgender> {

bool isFemale = false;
bool isMale = false;
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return Scaffold( backgroundColor: whiteColor,
body: SafeArea(child: Column(
children: [
Row(
children: [
arrowBackIcon(context),

SizedBox(width: sizeWidth/30),

Text('Assessment', style: theme.textTheme.displayLarge,),

SizedBox(width: sizeWidth/4.5),
 Chip( backgroundColor:  chipColor, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal( left: Radius.elliptical(15, 15),
 right: Radius.elliptical(15, 15))),
  label: Text('2 of 5', style: TextStyle( fontSize: 20, color: theme.primaryColor, ),))
],
),

SizedBox( height: sizeHeight/20),

Text('What is your gender?', style: theme.textTheme.labelLarge, textAlign: TextAlign.center,),

SizedBox( height: sizeHeight/30),

GestureDetector( onTap: (){
setState(() {
 isMale = true; isFemale = false;
});
},
child: menGenderContainer(sizeHeight, sizeWidth, theme)),

SizedBox( height: sizeHeight/30),

GestureDetector( onTap: (){
setState(() {
isFemale = true; isMale = false;
});
},
child: womenGenderContainer(sizeHeight, sizeWidth, theme, isFemale, isMale)),

SizedBox( height: sizeHeight/30),

skipGender(sizeWidth, sizeHeight, theme),

elevatedButton(sizeWidth, sizeHeight, (){
final  gender =  ref.read(userInfoProvider.notifier);
isMale? gender.saveGender('Male') : gender.saveGender('Female');
Navigator.push(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => SetWeight(),
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));
}, 'Continue')
]
)
),
    );
  }

SizedBox skipGender(double sizeWidth, double sizeHeight, ThemeData theme) {
    
return SizedBox( width: sizeWidth/1, height: sizeHeight/11,
child: Padding( 
padding: const EdgeInsets.all(12),
child: ElevatedButton(onPressed: (){
Navigator.push(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => SetWeight(),
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));

}, style: ElevatedButton.styleFrom( backgroundColor: chipColor,
shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30))),
child: Text('Prefer to skip, thanks!', style: TextStyle(fontSize: 16, color: theme.primaryColor))
),
),
);
  }

Container womenGenderContainer(double sizeHeight, double sizeWidth, ThemeData theme, bool isFemale, bool isMale) {
return Container( height: sizeHeight/5, width: sizeWidth/1.0, decoration: BoxDecoration( borderRadius: BorderRadius.horizontal(
right: Radius.elliptical(35, 35), left: Radius.elliptical(35, 35)
),
color: scaffold),
child: Row(
children: [
Padding(
padding:  EdgeInsets.all(sizeHeight/50),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
Row( 
children: [
Icon( Icons.female, color: theme.primaryColorDark, size: 35), 
Text('Female'),
],
),

Spacer(),

Container( height: sizeHeight/35, width: sizeWidth/16, decoration: BoxDecoration( color: null, border: Border.all(width: 3), 
borderRadius: BorderRadius.horizontal(right: Radius.elliptical(10, 10), left: Radius.elliptical(10, 10))
),
child: isFemale? Icon(Icons.circle, size: 20) : null, ),
  ],
),
),

Padding(
padding:  EdgeInsets.only(left: sizeWidth/60),
child: Container( height:  sizeHeight/5,  width: sizeWidth/1.54,
decoration: BoxDecoration( borderRadius: BorderRadius.horizontal(
right: Radius.elliptical(35, 35), left: Radius.elliptical(35, 35)
), color: lilacPurple
),
 child: Padding(
   padding:  EdgeInsets.only(bottom: 2.2),
   child: Image.asset('assets/images/womanrunning.png', fit: BoxFit.fill),
 ) ),
),
],
),
);
  }

Container menGenderContainer(double sizeHeight, double sizeWidth, ThemeData theme) {

return Container( height: sizeHeight/5, width: sizeWidth/1.0, decoration: BoxDecoration( borderRadius: BorderRadius.horizontal(
right: Radius.elliptical(35, 35), left: Radius.elliptical(35, 35)
),
color: scaffold, 
),
child: Row(
children: [
Padding(
padding:  EdgeInsets.all(sizeHeight/50),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
Row( 
children: [
Icon( Icons.male, color: theme.primaryColorDark, size: 35), 
Text('Male'),
],
),

Spacer(),

Container( height: sizeHeight/35, width: sizeWidth/16, decoration: BoxDecoration( color: null, border: Border.all(width: 3), 
borderRadius: BorderRadius.horizontal(right: Radius.elliptical(10, 10), left: Radius.elliptical(10, 10))),
 child: isMale? Icon(Icons.circle, size: 20) : null,),
  ],
),
),

Padding(
padding:  EdgeInsets.only(left: sizeWidth/60),
child: Container( height:  sizeHeight/5,  width: sizeWidth/1.45,
decoration: BoxDecoration(  color: yellowOrange, borderRadius: BorderRadius.horizontal(right: Radius.elliptical(35, 35), left: Radius.elliptical(35, 35))

),
 child: Image.asset('assets/images/manrunning.png', fit: BoxFit.fill) ),
),
],
),
);
  }
}