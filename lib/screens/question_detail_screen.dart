import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:stackover/models/questions.dart';
import 'package:stackover/services/app_colors.dart';
import 'package:stackover/services/app_constants.dart';
import 'package:stackover/services/app_helper.dart';
import 'package:stackover/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailScreen extends StatefulWidget {
  static const routeName = "/question-detail";

  const QuestionDetailScreen({Key? key}) : super(key: key);

  @override
  QuestionDetailScreenState createState() => QuestionDetailScreenState();
}

class QuestionDetailScreenState extends State<QuestionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as int;
    final question = Provider.of<Questions>(context, listen: false).findById(itemId);
    bool isConnected = Provider.of<Questions>(context,listen: false).isConnected;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppConstants.appBarHeight),
        child: MyAppBar(),
      ),
      body: Container(
        width: context.screenWidth,
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.title,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.8,
                crossAxisSpacing: 0, // افقي
                mainAxisSpacing: 0, // رأسي
              ),
              itemCount: question.tags.length,
              itemBuilder: (ctx, i) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).indicatorColor,
                ),
                margin: const EdgeInsets.only(top: 10, right: 10),
                padding: const EdgeInsets.all(10),
                child: Text(
                  question.tags[i].name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_rounded,
                    ),
                    Text(" (${question.viewCount}) view"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.question_answer,
                    ),
                    Text(" (${question.answerCount}) answer"),
                    if (question.isAnswered)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.successColor,
                      ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.score,
                    ),
                    Text(" ${question.score}"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: context.screenWidth * 0.6,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("asked ${question.fullDate}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      (isConnected)?
                      Image.network(
                        question.owner.image,
                        width: 60,
                        height: 60,
                      ):
                      Image.asset('assets/images/avatar.png',
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () => lunchUrl(question.owner.profile),
                            child: Text(
                              question.owner.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: AppColors.successColor,
                              ),
                              Text(question.lastActive),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  if (!await launchUrl(
                    Uri.parse(question.questionLink),
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw 'Could not launch ${question.questionLink}';
                  }
                },
                child: Text(
                  'View question on website!',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
