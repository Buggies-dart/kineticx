import 'package:flutter/material.dart';
import 'package:kineticx/Pages/Analytics/analytics.dart';
import 'package:kineticx/Pages/Explore/explore.dart';
import 'package:kineticx/Pages/Home/home.dart';
import 'package:kineticx/Pages/Profile/userprofile.dart';
import 'package:kineticx/Utils/pngs.dart';
import 'package:kineticx/Utils/components.dart';

class NavigationPage extends StatefulWidget {
const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

List <Widget> navPages = [ MyHomePage(), ExplorePage(), AnalyticsPage(), UserProfile()  ];

int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

double navButtonSize = 30;

final theme = Theme.of(context);
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
return  Scaffold(
backgroundColor: scaffold,
 extendBody: true,
bottomNavigationBar: Padding(
padding: const EdgeInsets.all(20),
  child: Container(  width: sizeWidth/1.3, height: sizeHeight/14, decoration: BoxDecoration(color: theme.primaryColorDark, borderRadius: BorderRadius.circular(40) ),
  child: ListView.builder( itemCount: navPages.length, scrollDirection: Axis.horizontal, itemBuilder: (context, index) {
  
  bool isSelected = selectedIndex == index;   
  final navButton = navButtons[index];
  
  return Padding(
  padding:  EdgeInsets.only(left: sizeWidth/20, right: sizeWidth/17),
  child: GestureDetector( onTap: (){
   setState(() {
  selectedIndex = index;
   }); 
   },
  child: Row( 
  children:  isSelected ?  [
  Container( width: sizeWidth/4, height: sizeHeight/23, decoration: BoxDecoration( borderRadius: BorderRadius.circular(20), color: selectedButtonColor 
   ),
  child: Row( mainAxisAlignment: MainAxisAlignment.center,
  children: [ Image.asset( navButton['button'], width: navButtonSize, color: theme.primaryColorDark,),
  Text(navButton['buttonText'], style: theme.textTheme.bodySmall,)  ]
  ),
  )] : 
  
  [Image.asset(navButton['button'], width: navButtonSize)]
  ),
  ),
  );
  },
  ),
  ),
),
body: navPages[selectedIndex],
);
}
}

// Navigation Widgets
List navButtons = [
{ 'button' : Buttons.home,
'buttonText': 'Home'}, 
{ 'button' : Buttons.explore,
'buttonText': 'Explore'}, 
{ 'button' : Buttons.statistic,
'buttonText': 'Analytics'}, 
{ 'button' : Buttons.profile,
'buttonText': 'Profile'}, 

  ];


// Move to Next Screen

Future<dynamic> moveToNextScreen( BuildContext context, Widget page){
return Navigator.push(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => page,
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));
}
Future<dynamic> pushReplacement( BuildContext context, Widget page){
return Navigator.pushReplacement(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => page,
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));
}