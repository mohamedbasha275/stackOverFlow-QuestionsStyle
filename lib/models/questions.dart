import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stackover/models/owner.dart';
import 'package:stackover/models/question.dart';
import 'package:stackover/models/tag.dart';
import 'package:stackover/services/app_helper.dart';
import 'package:stackover/services/check_net.dart';
import 'package:stackover/services/main_data.dart';


class Questions with ChangeNotifier {
  List<Question> items = [];

  List<Question> get questions {
    return [...items];
  }

  // load more
  bool isFinish = false;
  int nextPage = 1;
  setIsFinish(value){
    isFinish = value == null;
  }
  setNextPage(value){
    nextPage = value+1;
  }
  // net
  NetworkInfo net = NetworkInfoImpl(InternetConnectionChecker());
  bool isConnect = false;
  bool get isConnected{
    return isConnect;
  }
  setConnection(value){
    isConnect = value;
  }
  // get all questions
  Future<void> fetchQuestions() async {
    var url = "${mainUrl}questions?page=$nextPage&order=desc&sort=activity&site=stackoverflow";
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(await net.isConnected){
      setConnection(true);
      try {
        final res = await http.get(Uri.parse(url));
        final extracted = json.decode(res.body);
        final extractedData = extracted['items'];
        if (extractedData == null) {
          return;
        }
        final List<Question> loadedItems = [];
        getQuestionsData(loadedItems,extractedData);
        if(nextPage == 1){
          items = loadedItems;
          pref.setString('savedData',res.body.toString());
        }else{
          items.addAll(loadedItems);
        }
        if(nextPage < 25){
          setNextPage(nextPage);
          setIsFinish("no");
        }else{
          setIsFinish(null);
        }
        notifyListeners();
      } catch (err) {
        rethrow;
      }
    }else{
      setConnection(false);
      var saved = pref.getString('savedData');
      final extracted = json.decode(saved!);
      final extractedData = extracted['items'];
      if (extractedData == null) {
        return;
      }
      final List<Question> loadedItems = [];
      getQuestionsData(loadedItems,extractedData);
      items = loadedItems;
      notifyListeners();
    }
  }
  // get
  void getQuestionsData(loadedItems,extractedData){
    for (var item in extractedData) {
      List<Tag> loadedTags = [];
      item['tags'].forEach((itm) {
        loadedTags.add(Tag(name: itm.toString()));
      });
      loadedItems.add(Question(
        id: int.parse(item['question_id'].toString()),
        title: item['title'].toString(),
        owner: Owner(
          name: item['owner']['display_name'].toString(),
          image: item['owner']['profile_image'].toString(),
          profile: item['owner']['link'].toString(),
        ),
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
  }
  // findById
  Question findById(int id) {
    return items.firstWhere((item) => item.id == id);
  }
}