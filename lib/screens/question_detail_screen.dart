import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:stackover/models/main_data.dart';
import 'package:stackover/providers/questions.dart';
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
    final question =
        Provider.of<Questions>(context, listen: false).findById(itemId);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MyAppBar(),
      ),
      body: Container(
        width: context.screenWidth,
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
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
            SizedBox(height: 15,),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.4,
                crossAxisSpacing: 0, // افقي
                mainAxisSpacing: 0, // رأسي
              ),
              itemCount: question.tags.length,
              itemBuilder: (ctx, i) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(225, 236, 244, 1),
                ),
                margin: const EdgeInsets.only(top: 10, right: 10),
                padding: const EdgeInsets.all(10),
                child: Text(
                  question.tags[i],
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
                      const Icon(
                        Icons.check_circle,
                        color: Color.fromRGBO(47, 111, 69, 1),
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
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(218, 234, 248, 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("asked ${question.fullDate}"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if (question.ownerImage != null)
                        Image.network(
                          question.ownerImage,
                          width: 60,
                          height: 60,
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (!await launchUrl(
                                Uri.parse(question.ownerProfile),
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw 'Could not launch ${question.ownerProfile}';
                              }
                            },
                            child: Text(
                              question.ownerName,
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
                              const Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              Text("${question.lastActive}"),
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
