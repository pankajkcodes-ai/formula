import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/quizzes/quizzes_bloc.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/routes/routes.dart';
import 'package:formula/routes/routes_path.dart';
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
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
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
                      trailing: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push(RoutesName.quizDetailsRoute,
                              extra: totalQuizzes[index]);
                        },
                        child: const Text("Start",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      )),
                );
              },
            );
          },
        ));
  }
}
