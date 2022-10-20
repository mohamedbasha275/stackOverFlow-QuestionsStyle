import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackover/models/main_data.dart';
import 'package:stackover/providers/question.dart';
import 'package:stackover/screens/question_detail_screen.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<Question>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(QuestionDetailScreen.routeName, arguments: question.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).shadowColor,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: context.screenWidth * 0.84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.title,
                    //overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text("(${question.answerCount}) answers"),
                      const SizedBox(width: 5),
                      if(question.isAnswered)
                        const Icon(Icons.check_circle,color: Color.fromRGBO(47, 111, 69, 1),),
                      const SizedBox(width: 10),
                      if(question.ownerImage != null)
                      Image.network(question.ownerImage,width: 30,height: 30,),
                      const SizedBox(width: 5),
                      Text(question.ownerName,style: Theme.of(context).textTheme
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
