import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/shared/constatnt/colors.dart';


ThemeData lightMode = ThemeData(
  textTheme: const TextTheme(
    bodyText2: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black ,   fontFamily: 'Janna'
    ),
    bodyText1: TextStyle(
        fontFamily: 'Janna',  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    subtitle1: TextStyle(
        fontFamily: 'Janna', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    headline1: TextStyle(
        fontFamily: 'Janna', fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),

  ),
  primarySwatch: Colors.amber,


  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  const AppBarTheme(
      titleSpacing: 20,
      iconTheme:  IconThemeData(color: Colors.black, size: 30.0),
      elevation: 0.0,
      backgroundColor: Colors.white,

      systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle:  TextStyle(
          fontFamily: 'Janna'
          , fontSize: 20.0, color: Colors.black)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    selectedItemColor:defaultColor,
  ),
);

ThemeData darkMode = ThemeData(
    textTheme: const TextTheme(
      bodyText2:  TextStyle(
          fontFamily: 'Janna', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      subtitle1: TextStyle(
          fontFamily: 'Janna', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      headline1: TextStyle(
          fontFamily: 'Janna', fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    primarySwatch: Colors.amber,
floatingActionButtonTheme: FloatingActionButtonThemeData(
  splashColor: defaultColor,
),

    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        iconTheme: const IconThemeData(color: Colors.grey, size: 30.0),
        elevation: 0.0,
        backgroundColor: HexColor('333739'),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light),
        titleTextStyle: const TextStyle(  fontFamily: 'Janna'

            , fontSize: 20.0, color: Colors.grey)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20.0,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      selectedItemColor: defaultColor,
    ),
    fontFamily: 'Janna'
);
