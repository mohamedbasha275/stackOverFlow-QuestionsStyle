import 'package:flutter/material.dart';
// title
String mainTitle = "StackOverFlow";
// url
String mainUrl = "https://api.stackexchange.com/2.3/";
// width and height of screens
extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
/// ***********************************************************************
// lightTheme
final lightTheme = ThemeData(
  fontFamily: 'Cairo',
  primarySwatch: Colors.brown, // uses
  backgroundColor: const Color.fromRGBO(130, 210, 231, 1), // uses
  canvasColor: const Color.fromRGBO(255, 255, 255, 1), // background color of pages
  primaryColor: const Color.fromRGBO(85, 167, 151, 1),
  bottomAppBarColor: const Color.fromRGBO(107, 108, 107, 1),
  dividerColor: const Color.fromRGBO(220, 223, 227, 1),
  indicatorColor: const Color.fromRGBO(173, 212, 97,1), // uses
  shadowColor: const Color.fromRGBO(241, 242, 243, 1), // uses
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
/// *********************************************************************** ///
// loadingStyle
Widget loadingStyle(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 10),
        CircularProgressIndicator(),
        SizedBox(height: 10),
        Text('Loading...'),
      ],
    ),
  );
}
// no Items
Widget noItems(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
        Text('No items to show'),
        SizedBox(width: 5),
        //Icon(FontAwesomeIcons.heartCrack,color: Theme.of(context).appBarTheme.foregroundColor,),
      ],
    ),
  );
}
// screenStartWidget
Widget screenStartWidget(BuildContext context,bool isLoading, {var items, required Widget buildWidget}) {
  return isLoading ? loadingStyle(context): items.isEmpty ? noItems(context) : buildWidget;
}