import 'package:formula/model/pdf_category_model.dart';
import 'package:formula/model/subject_model.dart';
import 'package:formula/model/topic_model.dart';
import 'package:formula/views/01_home/pdf_category_list.dart';
import 'package:formula/views/01_home/pdf_list.dart';
import 'package:formula/views/01_home/pyq_list.dart';
import 'package:formula/views/widgets/coming_soon.dart';
import 'package:formula/views/04_quiz/quiz_details.dart';
import 'package:formula/views/04_quiz/quiz_list.dart';
import 'package:formula/views/04_quiz/quiz_solutions.dart';
import 'package:formula/views/04_quiz/result_summary.dart';
import 'package:formula/views/bookmark/q_bookmark_details.dart';
import 'package:formula/views/bookmark/q_bookmark_list.dart';
import 'package:formula/views/menu/feedback.dart';
import 'package:formula/views/menu/notifications.dart';
import 'package:formula/views/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/views/01_home/home_page.dart';
import 'package:formula/views/html_view//web_view_screen.dart';
import 'package:formula/views/02_topics/topics.dart';
import 'package:formula/views/03_sub_topics/sub_topics.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
      routes: [
        GoRoute(
            name: RoutesName.splashRoute,
            path: "/",
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            }),
        GoRoute(
            name: RoutesName.homeScreenRoute,
            path: RoutesName.homeScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            }),
        GoRoute(
            name: RoutesName.comingSoonScreenRoute,
            path: RoutesName.comingSoonScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const ComingSoon();
            }),
        GoRoute(
            name: RoutesName.notificationRoute,
            path: RoutesName.notificationRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const Notifications();
            }),
        GoRoute(
            name: RoutesName.feedbackRoute,
            path: RoutesName.feedbackRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const MyFeedback();
            }),
        GoRoute(
            name: RoutesName.quizListRoute,
            path: RoutesName.quizListRoute,
            builder: (BuildContext context, GoRouterState state) {
              final String type = state.extra as String;
              return QuizList(type: type);
            }),
        GoRoute(
            name: RoutesName.pyqListRoute,
            path: RoutesName.pyqListRoute,
            builder: (BuildContext context, GoRouterState state) {
              // final String type = state.extra as String;
              return const PyqList();
            }),
        GoRoute(
            name: RoutesName.pdfCategoryListRoute,
            path: RoutesName.pdfCategoryListRoute,
            builder: (BuildContext context, GoRouterState state) {
              // final String type = state.extra as String;
              return const PdfCategoryList();
            }),
        GoRoute(
            name: RoutesName.pdfListRoute,
            path: RoutesName.pdfListRoute,
            builder: (BuildContext context, GoRouterState state) {
              final PdfCategoryModel type = state.extra as PdfCategoryModel;
              return PdfList(pdfCategoryModel: type,);
            }),
        GoRoute(
            name: RoutesName.quizDetailsRoute,
            path: RoutesName.quizDetailsRoute,
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> data =
                  state.extra as Map<String, dynamic>;

              return QuizDetails(
                quizzesModel: data["quizModel"],
                type: data['type'],
              );
            }),
        GoRoute(
            name: RoutesName.quizSolutionsRoute,
            path: RoutesName.quizSolutionsRoute,
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> data =
                  state.extra as Map<String, dynamic>;
              return QuizSolutions(
                quizzesModel: data["quizModel"],
                resultModel: data["resultModel"],
                type: data["type"],
              );
            }),
        GoRoute(
            name: RoutesName.resultSummaryRoute,
            path: RoutesName.resultSummaryRoute,
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> data =
                  state.extra as Map<String, dynamic>;
              return ResultSummary(
                resultModel: data["resultModel"],
                quizzesModel: data["quizModel"],
                type: data["type"],
              );
            }),
        GoRoute(
            name: RoutesName.topicsRoute,
            path: RoutesName.topicsRoute,
            builder: (BuildContext context, GoRouterState state) {
              SubjectModel subjectModel = state.extra as SubjectModel;
              return Topics(subjectModel: subjectModel);
            }),
        GoRoute(
            name: RoutesName.subTopicsRoute,
            path: RoutesName.subTopicsRoute,
            builder: (BuildContext context, GoRouterState state) {
              TopicModel subTopicModel = state.extra as TopicModel;
              return SubTopics(topicModel: subTopicModel);
            }),
        GoRoute(
            name: RoutesName.qBookmarkListRoute,
            path: RoutesName.qBookmarkListRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const QuestionBookmarkList();
            }),
        GoRoute(
            name: RoutesName.qBookmarkDetailsRoute,
            path: RoutesName.qBookmarkDetailsRoute,
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> data =
                  state.extra as Map<String, dynamic>;

              return QuestionBookmarkDetails(
                id: data['id'],
                type: data['type'],
              );
            }),
        GoRoute(
            name: RoutesName.htmlViewRoute,
            path: RoutesName.htmlViewRoute,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;

              return WebViewFormulaPage(url: data["url"], title: data["title"]);
            }),
      ],
      errorBuilder: (context, state) {
        return Text(state.error.toString());
      });
}
