import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      shadowColor: Theme.of(context).appBarTheme.shadowColor,
      elevation: 2.0,
      automaticallyImplyLeading: false, // hides leading widget
      flexibleSpace: Container(
        margin: const EdgeInsets.only(top: 30,bottom: 5),
        child: Center(
          child: Image.asset("assets/images/logo.png",width: 200,),
        ),
      ),
    );
  }
}