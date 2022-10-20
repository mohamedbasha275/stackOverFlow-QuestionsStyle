import 'package:flutter/foundation.dart';
import 'package:stackover/models/owner.dart';
import 'package:stackover/models/tag.dart';

class Question with ChangeNotifier {
  final int id;
  final String title;
  final Owner owner;
  final bool isAnswered;
  final int viewCount;
  final int answerCount;
  final int score;
  final String creationDate;
  final String fullDate;
  final String lastActive;
  final String questionLink;
  final List<Tag> tags;

  Question({
    required this.id,
    required this.title,
    required this.owner,
    required this.isAnswered,
    required this.viewCount,
    required this.answerCount,
    required this.score,
    required this.creationDate,
    required this.fullDate,
    required this.lastActive,
    required this.questionLink,
    required this.tags,
  });
}
