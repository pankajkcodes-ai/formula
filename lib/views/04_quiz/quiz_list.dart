import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/quizzes/quizzes_bloc.dart';
import 'package:formula/data/local/database_helper.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/model/result_model.dart';
import 'package:formula/routes/routes.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/views/04_quiz/quiz_details.dart';
import 'package:formula/views/04_quiz/quiz_re_attempt.dart';
import 'package:go_router/go_router.dart';

class QuizList extends StatefulWidget {
  const QuizList({super.key});

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  @override
  void initState() {
    context.read<QuizzesBloc>().add(QuizzesGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz"),
        ),
        body: BlocConsumer<QuizzesBloc, QuizzesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            List<QuizzesModel> totalQuizzes = [];

            if (state is QuizzesGetState) {
              totalQuizzes = state.quizzes;
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              itemCount: totalQuizzes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  clipBehavior: Clip.none,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 7.0),
                      title: Text(
                        "${totalQuizzes[index].title}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            "${totalQuizzes[index].totalQuestions}"
                            " Qs. ${totalQuizzes[index].totalTime} min. ${totalQuizzes[index].totalPoints} Points",
                            style: const TextStyle(fontSize: 12)),
                      ),
                      trailing: PrefService.isQuizAttempted(
                              totalQuizzes[index].id.toString())
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    QuizDatabaseHelper.getAttemptById(
                                            int.parse(totalQuizzes[index].id!))
                                        .then((value) {
                                      print("Babu : $value");

                                      // Convert to Map<String, dynamic>
                                      Map<int, String> convertedAnswers =
                                          value!.map((key, value) {
                                        // Convert key to String and keep the value as is
                                        return MapEntry(
                                            int.parse(key.toString()),
                                            value.toString());
                                      });

                                      GoRouter.of(context).pushNamed(
                                          RoutesName.quizSolutionsRoute,
                                          extra: {
                                            "resultModel": ResultModel(
                                                totalMarks: 0,
                                                obtainMarks: 0,
                                                percentage: 0,
                                                totalQuestions:
                                                    totalQuizzes[index]
                                                        .totalQuestions!
                                                        .length,
                                                correctAnswers: 0,
                                                wrongAnswers: 0,
                                                notAttempt: 0,
                                                totalTime: int.parse(
                                                    totalQuizzes[index]
                                                        .totalTime
                                                        .toString()),
                                                selectedOptionIndices:
                                                    convertedAnswers),
                                            "quizModel": totalQuizzes[index],
                                          });
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(),
                                    ),
                                    child: const Text("Solutions",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizReattempt(
                                                  quizzesModel:
                                                      totalQuizzes[index],
                                                  isReAttempt: true,
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(),
                                    ),
                                    child: const Text("ReAttempt",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () {
                                GoRouter.of(context).push(
                                    RoutesName.quizDetailsRoute,
                                    extra: totalQuizzes[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7.0, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(),
                                ),
                                child: const Text("Start",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                );
              },
            );
          },
        ));
  }
}
