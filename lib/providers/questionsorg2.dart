import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stackover/models/main_data.dart';
import 'package:stackover/providers/question.dart';

class Questions with ChangeNotifier {
  List<Question> items = [];

  List<Question> get questions {
    return [...items];
  }

  // convert time stamp to date
  String translateToDate(timestamp){
   var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
   //return DateFormat('dd/MM/yyyy, HH:mm').format(dt).toString();
   return DateFormat('dd-MMM-yyyy').format(dt).toString();
  }
  // convert time stamp to full time
  String translateToFullDate(timestamp){
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var date = DateFormat('dd MMM').format(dt).toString();
    var time = DateFormat('HH:mm').format(dt).toString();
    return "$date at $time";
  }
  // get all questions
  Future<void> fetchQuestions({teacherId}) async {
    var url = mainUrl;
    try {
      final res = await http.get(Uri.parse(url));
      final extracted = json.decode(res.body);
      final extractedData = extracted['items'];
      if (extractedData == null) {
        return;
      }
      final List<Question> loadedItems = [];
      for (var item in extractedData) {
        List<String> loadedTags = [];
        item['tags'].forEach((itm) {
          loadedTags.add(itm);
        });
        loadedItems.add(Question(
          id: int.parse(item['question_id'].toString()),
          title: item['title'].toString(),
          ownerName: item['owner']['display_name'].toString(),
          ownerImage: item['owner']['profile_image'].toString(),
          ownerProfile: item['owner']['link'].toString(),
          isAnswered: item['is_answered'],
          viewCount: int.parse(item['view_count'].toString()),
          answerCount: int.parse(item['answer_count'].toString()),
          score: int.parse(item['score'].toString()),
          creationDate: translateToDate(item['creation_date']).toString(),
          fullDate: translateToFullDate(item['creation_date']).toString(),
          lastActive: translateToFullDate(item['last_activity_date']).toString(),
          questionLink: item['link'].toString(),
          tags: loadedTags,
        ));
      }
      items = loadedItems;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
  // findById
  Question findById(int id) {
    return items.firstWhere((item) => item.id == id);
  }
}