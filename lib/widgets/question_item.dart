import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackover/models/question.dart';
import 'package:stackover/models/questions.dart';
import 'package:stackover/screens/question_detail_screen.dart';
import 'package:stackover/services/app_colors.dart';
import 'package:stackover/services/app_helper.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<Question>(context, listen: false);
    bool isConnected = Provider.of<Questions>(context,listen: false).isConnected;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(QuestionDetailScreen.routeName, arguments: question.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: context.screenWidth * 0.82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text("(${question.answerCount}) answers"),
                      const SizedBox(width: 5),
                      if(question.isAnswered)
                         Icon(Icons.check_circle,color: AppColors.successColor,),
                      const SizedBox(width: 10),
                      (isConnected)?
                      Image.network(question.owner.image,width: 30,height: 30,):
                      Image.asset('assets/images/avatar.png',width: 30,height: 30,),
                      const SizedBox(width: 5),
                      Text(question.owner.name,style: Theme.of(context).textTheme
                          .headline5!.copyWith(fontSize: 12),),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Added at: ${question.creationDate}",
                    style: const TextStyle(fontSize: 12),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
