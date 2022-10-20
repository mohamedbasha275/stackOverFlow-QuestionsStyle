import 'package:flutter/foundation.dart';

class Question with ChangeNotifier {
  final int id;
  final String title;
  final String ownerName;
  final String ownerImage;
  final String ownerProfile;
  final bool isAnswered;
  final int viewCount;
  final int answerCount;
  final int score;
  final String creationDate;
  final String fullDate;
  final String lastActive;
  final String questionLink;
  final List<String> tags;

  Question({
    required this.id,
    required this.title,
    required this.ownerName,
    required this.ownerImage,
    required this.ownerProfile,
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
