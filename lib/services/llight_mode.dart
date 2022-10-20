import 'package:flutter/material.dart';
/// ***********************************************************************
// lightTheme
final lightTheme = ThemeData(
  primarySwatch: Colors.brown,
  backgroundColor: const Color.fromRGBO(241, 242, 243, 1),
  shadowColor: const Color.fromRGBO(241, 242, 243, 1),
  indicatorColor: const Color.fromRGBO(225, 236, 244, 1),
  //canvasColor: const Color.fromRGBO(218, 234, 248, 1),
  // primaryColor: const Color.fromRGBO(85, 167, 151, 1),
  // bottomAppBarColor: const Color.fromRGBO(107, 108, 107, 1),
  // dividerColor: const Color.fromRGBO(220, 223, 227, 1),
  // app bar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    shadowColor: Colors.grey,
    foregroundColor: Colors.black,
  ),
  // text
  textTheme: const TextTheme(
    // used
    headline1: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(52, 52, 52, 1),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    // used
    headline2: TextStyle(
      color: Color.fromRGBO(83, 82, 88, 1.0),
      fontSize: 27,
      fontWeight: FontWeight.w500,
      fontFamily: 'Cairo',
    ),
    // used
    headline3: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(83, 82, 88, 1.0),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    // used
    headline4: TextStyle(
      fontFamily: 'Cairo',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
    // used used
    headline5: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(0, 116, 204, 1),
      fontSize: 15,
    ),
    //used
    headline6: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(134, 136, 141, 1),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    // uses
    bodyText1: TextStyle(
      color: Colors.black87,
      fontFamily: 'Cairo',
      fontSize: 16,
    ),
    // default of all  texts
    bodyText2: TextStyle(
      color: Color.fromRGBO(134, 136, 141, 1),
      fontFamily: 'Cairo',
    ),
  ),
);
/// *********************************************************************** 