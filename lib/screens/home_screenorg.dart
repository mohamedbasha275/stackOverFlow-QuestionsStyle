import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackover/models/main_data.dart';
import 'package:stackover/providers/questions.dart';
import 'package:stackover/widgets/app_bar.dart';
import 'package:stackover/widgets/question_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    // ==TODO: implement initState
    super.initState();
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Questions>(context, listen: false).fetchQuestions().then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }).catchError((onError) => onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = Provider.of<Questions>(context, listen: false).questions;
    return Scaffold(
      //key: _scaffoldKey,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MyAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            screenStartWidget(
              context,
              _isLoading,
              items: questions,
              buildWidget: Column(
                children: [
                  Container(
                    width: context.screenWidth,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 15),
                    child: Text(
                      "All Questions",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: questions[i],
                      child: const QuestionItem(),
                    ),
                    itemCount: questions.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
