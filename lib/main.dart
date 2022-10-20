import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackover/models/main_data.dart';
import 'package:stackover/models/routes.dart';
import 'package:stackover/providers/questions.dart';
import 'package:stackover/providers/question.dart';
import 'package:stackover/screens/home_screen.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => Question(
                id: 1,
                title: '',
                ownerName: '',
                ownerImage: '',
                ownerProfile: '',
                isAnswered: false,
                viewCount: 0,
                fullDate: '',
                lastActive: '',
                answerCount: 0,
                score: 0,
                creationDate: '',
                questionLink: '',
                tags: [])),
        ChangeNotifierProvider(create: (_) => Questions()),
      ],
      child: MaterialApp(
        title: mainTitle,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const HomeScreen(),
        routes: routes,
      ),
    );
  }
}
