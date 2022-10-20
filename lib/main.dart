import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackover/models/owner.dart';
import 'package:stackover/models/question.dart';
import 'package:stackover/models/questions.dart';
import 'package:stackover/screens/home_screen.dart';
import 'package:stackover/services/app_colors.dart';
import 'package:stackover/services/llight_mode.dart';
import 'package:stackover/services/main_data.dart';
import 'package:stackover/services/routes.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.statusBarColor,
        systemNavigationBarColor: AppColors.navigationBarColor,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => Question(
                id: 1,
                title: '',
                owner: Owner(name: '', image: '', profile: ''),
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
