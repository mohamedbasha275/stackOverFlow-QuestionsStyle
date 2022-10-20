import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:stackover/models/questions.dart';
import 'package:stackover/services/app_constants.dart';
import 'package:stackover/services/app_helper.dart';
import 'package:stackover/widgets/app_bar.dart';
import 'package:stackover/widgets/question_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({super.key});
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
    final questions = Provider.of<Questions>(context).questions;
    bool isFinished = Provider.of<Questions>(context,listen: false).isFinish;
    bool isConnected = Provider.of<Questions>(context,listen: false).isConnected;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppConstants.appBarHeight),
        child: MyAppBar(),
      ),
      body: Container(
        child: screenStartWidget(
          context,
          _isLoading,
          items: questions,
          buildWidget: Container(
            margin: const EdgeInsets.only(top: 15),
            child: LoadMore(
              isFinish: isConnected == false ? true : isFinished,
              onLoadMore: _loadMore,
              whenEmptyLoad: false,
              delegate: const DefaultLoadMoreDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.english,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: questions[i],
                  child: const QuestionItem(),
                ),
                itemCount: questions.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    await Provider.of<Questions>(context, listen: false).fetchQuestions();
    return !Provider.of<Questions>(context,listen: false).isFinish;
  }
}
