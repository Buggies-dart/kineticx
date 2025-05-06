import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kineticx/Features/Pages/Onboarding%20screens/Assessments/setgender.dart';
import 'package:kineticx/Widgets/widgets.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:kineticx/main.dart';

class SetFitnessTarget extends ConsumerStatefulWidget {
  const SetFitnessTarget({super.key});

  @override
  ConsumerState<SetFitnessTarget> createState() => _SetFitnessTargetState();
}

class _SetFitnessTargetState extends ConsumerState<SetFitnessTarget> {
int? selectedIndex;
  @override
  Widget build(BuildContext context) {
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);

return Scaffold( backgroundColor: whiteColor,
body: SafeArea(
child: Column(
children: [
Row(
children: [
arrowBackIcon(context),

SizedBox(width: sizeWidth/30),

Text('Assessment', style: theme.textTheme.displayLarge,),

SizedBox(width: sizeWidth/4.5),
 Chip( backgroundColor:  chipColor, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal( left: Radius.elliptical(15, 15),
 right: Radius.elliptical(15, 15))),
  label: Text('1 of 5', style: TextStyle( fontSize: 20, color: theme.primaryColor, ),))
],
),

SizedBox( height: sizeHeight/20),

Text('What\'s Your Fitness\ngoal/target?', style: theme.textTheme.labelLarge, textAlign: TextAlign.center,),

SizedBox( height: sizeHeight/30),

Expanded(
  child: ListView.builder( itemCount: tileAssets.length,  padding: EdgeInsets.only(top: 0), itemBuilder: (context, index) {
  final tileAssset = tileAssets[index];
  bool isSelected = selectedIndex == index;
  return  listTile(sizeHeight, sizeWidth, theme, tileAssset['Icon'], tileAssset['Action'], isSelected,
(){
setState(() {
selectedIndex = index;
});


});
  },),
),

elevatedButton(sizeWidth, sizeHeight, (){
final fitnessTarget = tileAssets[selectedIndex!]['Target'];
ref.read(userInfoProvider.notifier).setFitnessTarget(fitnessTarget);
Navigator.push(context, PageRouteBuilder(
pageBuilder: (context, animation, secondaryAnimation) => Setgender(),
transitionsBuilder: (context, animation, secondaryAnimation, child) {
return FadeTransition( opacity: animation, child: child,
);
},
));
}, 'Continue')
],
  )
),
    );
  }

Padding listTile(double sizeHeight, double sizeWidth, ThemeData theme, IconData icon, String text, bool isSelected, VoidCallback tap) {
    return Padding(
padding: const EdgeInsets.all(8.0),
child: Container( decoration: BoxDecoration(border: Border.all(width: isSelected? 7 : 0, color: chipColor), 
borderRadius: BorderRadius.all(Radius.elliptical(32, 32))),
  child: ListTile( onTap: tap,
   tileColor: isSelected? theme.primaryColor: scaffold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.elliptical(25, 25), left: Radius.elliptical(25, 25))),
  contentPadding: EdgeInsets.only( top: sizeHeight/70, bottom: sizeHeight/70),
  
  leading:  Padding( padding: EdgeInsets.only(left: sizeWidth/25),
  child: Icon(icon, color: isSelected? theme.colorScheme.surfaceContainer : theme.colorScheme.onPrimaryFixedVariant, size: 35,)),
  title: Text(text, style: isSelected? TextStyle(fontSize: 18, fontFamily: fontFam, color: whiteColor, fontWeight: FontWeight.bold) : theme.textTheme.titleMedium),
  
  trailing: Padding(
  padding:  EdgeInsets.only(right: sizeWidth/25),
  child: isSelected? 
  
  Container( height: sizeHeight/35, width: sizeWidth/15, decoration: BoxDecoration( border: Border.all(width: 3, color: whiteColor), 
  borderRadius: BorderRadius.horizontal(right: Radius.elliptical(10, 10), left: Radius.elliptical(10, 10))),
   child: Icon(Icons.square, color: whiteColor, size: 15),)
  : 
  Container( height: sizeHeight/35, width: sizeWidth/15, decoration: BoxDecoration( color: null, border: Border.all(width: 3), 
  borderRadius: BorderRadius.horizontal(right: Radius.elliptical(10, 10), left: Radius.elliptical(10, 10))),
   ),
  )),
),
);
  }
}

List<Map<String, dynamic>> tileAssets = [
  {
'Icon' : Icons.monitor_weight,
'Action' : 'I wanna lose weight',
'Target' : 'Weightloss'
},
  {
'Icon' : Icons.smart_toy,
'Action' : 'I wanna try AI coach',
'Target' : 'AI'

},
  {
'Icon' : MdiIcons.dumbbell,
'Action' : 'I wanna get bulk',
'Target' : 'Muscle'
},
  {
'Icon' : Icons.bolt,
'Action' : 'I wanna gain endurance',
'Target' : 'Endurance'
},
  {
'Icon' : Icons.person,
'Action' : 'Just trying out the app!',
'Target' : 'Weightloss'
},
];