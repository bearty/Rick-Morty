import 'package:flutter/material.dart';
import 'package:ricknmorty/theme/color_theme.dart';

final darkTheme = ThemeData(
  fontFamily: 'Roboto',
  // primarySwatch: Colors.grey,
  primaryColor: AppColors.primaryDark,
  brightness: Brightness.dark,
  // backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  // accentIconTheme: IconThemeData(color: Colors.black),
  canvasColor: AppColors.lightBlack,
  dividerColor: AppColors.lightBlack,
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: AppColors.primaryDark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: AppColors.green,
    unselectedItemColor: AppColors.gray,
    
  ),
  textTheme: TextTheme(
    headline4: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 34,
      letterSpacing: 0.25,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.15,
      color: Colors.white,
    ),
    overline: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 10,
      letterSpacing: 1.5,
      color: AppColors.textOverlineDark,
    ),
    caption: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.5,
      color: AppColors.subTitle,
    ),
    bodyText1: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.44,
      color: AppColors.textOverlineDark,
    ),
    bodyText2: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.25,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.15,
      color: AppColors.textOverlineDark,
    ),
  ),
  dialogBackgroundColor: AppColors.lightBlack,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((state) => Colors.white),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.lightBlack,
  ),
);

///
/// APPLICATION LIGHT STYLE
///
final lightTheme = ThemeData(
  fontFamily: 'Roboto',
  // primarySwatch: Colors.grey,
  primaryColor: AppColors.primaryLight,
  brightness: Brightness.light,
  // backgroundColor: const Color(0xFFE5E5E5),
  accentColor: AppColors.black,
  // accentIconTheme: IconThemeData(color: Colors.white),
  canvasColor: Colors.white,
  dividerColor: AppColors.dividerLight,
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      color: AppColors.textOverlineLight,
    ),
  ),
  scaffoldBackgroundColor: AppColors.primaryLight,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: AppColors.blue,
    unselectedItemColor: AppColors.gray4,
  ),
  textTheme: TextTheme(
    headline4: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 34,
      letterSpacing: 0.25,
      color: AppColors.black,
    ),
    headline6: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.15,
      color: AppColors.black,
    ),
    overline: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 10,
      letterSpacing: 1.5,
      color: AppColors.textOverlineLight,
    ),
    caption: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.5,
      color: AppColors.textOverlineLight,
    ),
    bodyText1: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.44,
      color: AppColors.textOverlineLight,
    ),
    bodyText2: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.25,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.15,
      color: AppColors.textOverlineLight,
    ),
  ),
  dialogBackgroundColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((state) => AppColors.buttonText),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.dividerLight,
  ),
);
