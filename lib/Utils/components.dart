import 'package:flutter/material.dart';
 
//  PRIMARY COLORS
const blackColor = Color(0xFF192126);
const whiteColor = Colors.white;
const brightGreen = Color(0xFFBBF246);
const scaffold = Color(0xFFF0F0F2);
const textColorBlack = Color(0xFF192126);
const containerWhite = Color(0xFFF2F2F2);
const selectedButtonColor = Color(0xFFBBF246);


// SECODARY COLORS
const steelGray = Color(0xFF8B8F92);
const slateGray = Color(0xFF5E6468);
const darkSlateGray = Color(0xFF384046);
const lilacPurple = Color(0xFFA48AED);
const tomatoRed = Color(0xFFED4747);
const yellowOrange = Color(0xFFFCC46F);
const skyBlue = Color(0xFF95CCE3);
const chipColor =  Color.fromARGB(255, 241, 252, 217);
const smallChipColor = Color(0xFFF1F1F1);


const String fontFam = 'Lato';


class Pallete{
 static var lightTheme = ThemeData.light().copyWith(
scaffoldBackgroundColor: scaffold,
primaryColorDark: blackColor,
primaryColor: brightGreen,
primaryColorLight: lilacPurple ,
colorScheme: ColorScheme.light(
onPrimaryContainer: steelGray,
onPrimaryFixedVariant: slateGray,
surfaceContainer: whiteColor,
tertiaryContainer: smallChipColor,
onErrorContainer: tomatoRed
),

bottomNavigationBarTheme: BottomNavigationBarThemeData(
backgroundColor: Colors.black,
),
textTheme: TextTheme(

displayLarge: TextStyle(
fontFamily: fontFam, fontSize: 30, fontWeight: FontWeight.w900, color: textColorBlack
),

labelLarge: TextStyle(
fontFamily: fontFam, fontSize: 32, fontWeight: FontWeight.w900, color: textColorBlack
),

displaySmall: TextStyle(
fontSize: 15, fontFamily: fontFam,    
),

titleSmall: TextStyle(
fontSize: 14, fontFamily: fontFam, fontWeight: FontWeight.bold, color: textColorBlack
),

bodyMedium: TextStyle(fontSize: 15, fontFamily: fontFam, color: textColorBlack),

bodySmall: TextStyle(fontSize: 13, fontFamily: fontFam, color: textColorBlack),

titleMedium: TextStyle(fontSize: 18, fontFamily: fontFam, color: blackColor, fontWeight: FontWeight.w900),

titleLarge: TextStyle(fontFamily: fontFam, fontSize: 30, fontWeight: FontWeight.bold, color: whiteColor
),

labelSmall: TextStyle(
fontFamily: fontFam, fontSize: 12, color: textColorBlack
),

headlineSmall: TextStyle(
fontFamily: fontFam, fontSize: 10, color: whiteColor
),

headlineMedium: TextStyle(
fontFamily: fontFam, fontSize: 16, color: textColorBlack, fontWeight: FontWeight.w600
),


)
 );
}