import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/model/result_model.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:go_router/go_router.dart';

class ResultSummary extends StatefulWidget {
  final ResultModel resultModel;
  final QuizzesModel quizzesModel;

  const ResultSummary(
      {super.key, required this.resultModel, required this.quizzesModel});

  @override
  State<ResultSummary> createState() => _ResultSummaryState();
}

class _ResultSummaryState extends State<ResultSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Summary'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(11),
        children: [
          Center(
            child: Container(
                margin: const EdgeInsets.all(11),
                height: 100,
                child: Image.asset('assets/images/leader-board.png')),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.question_mark),
                  title: const Text('Total Marks'),
                  trailing: Text('${widget.resultModel.totalMarks}'),
                ),
                ListTile(
                  leading: const Icon(Icons.done),
                  title: const Text('Your Marks'),
                  trailing: Text('${widget.resultModel.obtainMarks}'),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.question_mark),
                  title: const Text('Total Questions'),
                  trailing: Text('${widget.resultModel.totalQuestions}'),
                ),
                ListTile(
                  leading: const Icon(Icons.done),
                  title: const Text('Correct Answers'),
                  trailing: Text('${widget.resultModel.correctAnswers}'),
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('Wrong Answers'),
                  trailing: Text('${widget.resultModel.wrongAnswers}'),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Not Answered'),
                  trailing: Text('${widget.resultModel.notAttempt}'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(RoutesName.quizSolutionsRoute, extra: {
                      "quizModel": widget.quizzesModel,
                      "resultModel": widget.resultModel,
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: Resources.dimens.width(context) * 0.4,
                    decoration:
                    Resources.styles.kBoxBorderDecorationR3(context),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Solutions',
                            style: Resources.styles.kTextStyle14B5(Theme.of(context).colorScheme.tertiaryFixed)
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                                size: 14, Icons.arrow_forward_ios_rounded)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.settings.name == RoutesName.quizListRoute);

                    GoRouter.of(context).pushReplacement(RoutesName.quizListRoute);


                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: Resources.dimens.width(context) * 0.4,
                    decoration:
                    Resources.styles.kBoxBorderDecorationR3(context),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '      Done    ',
                            style: Resources.styles.kTextStyle14B5(Theme.of(context).colorScheme.tertiaryFixed)
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                                size: 14, Icons.arrow_forward_ios_rounded)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
