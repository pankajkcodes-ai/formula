import 'package:flutter/foundation.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/data/network/base_api_service.dart';
import 'package:formula/data/network/network_api_service.dart';
import 'package:formula/model/pdf_category_model.dart';
import 'package:formula/model/pdf_model.dart';
import 'package:formula/model/question_model.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/model/sub_topic_model.dart';
import 'package:formula/model/subject_model.dart';
import 'package:formula/model/topic_model.dart';
import 'package:formula/res/app_urls.dart';

class Repository {
  final BaseApiServices _apiServices = NetworkApiServices();

  // GET SUBJECTS
  Future<List<SubjectModel>> getSubjects() async {
    try {
      List<SubjectModel> list = [];
      var url = "${AppUrls.subjectEndPoint}?status=Active";

      dynamic response = await _apiServices.getApiResponse(url);

      if (kDebugMode) {
        print("Response get subject name: $response");
      }
      if (response["data"]["subjects"] == null) {
        return [];
      }
      List result = response["data"]["subjects"];

      for (int i = 0; i < result.length; i++) {
        SubjectModel data =
            SubjectModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }

  // GET TOPICS
  Future<List<TopicModel>> getTopics(String subject) async {
    try {
      List<TopicModel> list = [];
      var url = AppUrls.topicEndPoint;

      dynamic response =
          await _apiServices.getApiResponse("$url?subject=$subject");

      if (kDebugMode) {
        print("Response get brand name: $response");
      }
      if (response["data"]["topics"] == null) {
        return [];
      }
      List result = response["data"]["topics"];

      for (int i = 0; i < result.length; i++) {
        TopicModel data =
            TopicModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }

  // GET SUB TOPICS
  Future<List<SubTopicModel>> getSubTopics(TopicModel topicModel) async {
    try {
      List<SubTopicModel> list = [];
      var url = AppUrls.subTopicEndPoint;

      dynamic response = await _apiServices.getApiResponse(
          "$url?subject=${topicModel.subjectId}&topic=${topicModel.id}");

      if (kDebugMode) {
        print("Response get brand name: $response");
      }
      if (response["data"]["sub_topics"] == null) {
        return [];
      }
      List result = response["data"]["sub_topics"];

      for (int i = 0; i < result.length; i++) {
        SubTopicModel data =
            SubTopicModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }

  // GET QUIZZES
  Future<List<QuizzesModel>> getQuizzes(String type) async {
    try {
      List<QuizzesModel> list = [];
      var url = AppUrls.quizzedEndPoint;

      dynamic response =
          await _apiServices.getApiResponse("$url?orderBy=desc&type=$type");

      if (kDebugMode) {
        print("Response get brand name: $response");
      }
      if (response["data"]["quizzes"] == null) {
        return [];
      }
      List result = response["data"]["quizzes"];

      for (int i = 0; i < result.length; i++) {
        QuizzesModel data =
            QuizzesModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }

  // GET QUESTIONS
  Future<List<QuestionModel>> getQuestions(String quizId, String type,
      {List<String>? idList = const []}) async {
    try {
      List<QuestionModel> list = [];
      var url = AppUrls.questionsEndPoint;

      if (quizId != "") {
        url = "$url?quizId=$quizId&type=$type";
      } else if (idList != null && idList.isNotEmpty && quizId == "") {
        url = "$url?idList=$idList&type=$type";
      } else {
        url = "$url?quizId=-1";
      }

      dynamic response = await _apiServices.getApiResponse(url);

      if (kDebugMode) {
        print("Response get brand name: $response");
      }
      if (response["data"]["questions"] == null) {
        return [];
      }
      List result = response["data"]["questions"];

      for (int i = 0; i < result.length; i++) {
        QuestionModel data =
            QuestionModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }

  // GET SUBJECTS
  Future<List<PdfCategoryModel>> getPdfCategories() async {
    try {
      List<PdfCategoryModel> list = [];
      var url =
          "${AppUrls.pdfCategoryEndPoint}?status=Active&language=${selectedLanguage == LanguageEnums.english ? 'en' : "hi"}";

      dynamic response = await _apiServices.getApiResponse(url);

      if (kDebugMode) {
        print("Response get subject name: $response");
      }
      if (response["data"]["pdf_categories"] == null) {
        return [];
      }
      List result = response["data"]["pdf_categories"];

      for (int i = 0; i < result.length; i++) {
        PdfCategoryModel data =
            PdfCategoryModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }

// GET SUBJECTS
  Future<List<PdfModel>> getPdfs(String categoryId) async {
    try {
      List<PdfModel> list = [];
      var url =
          "${AppUrls.uploadsEndPoint}?pdf_category=$categoryId&language=${selectedLanguage == LanguageEnums.english ? 'en' : "hi"}";

      dynamic response = await _apiServices.getApiResponse(url);

      if (kDebugMode) {
        print("Response get subject name: $response");
      }
      if (response["data"]["uploads"] == null) {
        return [];
      }
      List result = response["data"]["uploads"];

      for (int i = 0; i < result.length; i++) {
        PdfModel data = PdfModel.fromJson(result[i] as Map<String, dynamic>);
        list.add(data);
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      rethrow;
    }
  }
}
