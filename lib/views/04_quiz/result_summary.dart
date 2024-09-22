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
          SizedBox(height: 11),
          Padding(
            padding: const EdgeInsets.all(5.0),
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
                    height: Resources.dimens.height(context) * 0.06,
                    width: Resources.dimens.width(context) * 0.4,
                    decoration:
                        Resources.styles.kBoxBorderDecoration(radius: 7),
                    child: const Center(child: Text('Solution')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Container(
                    height: Resources.dimens.height(context) * 0.06,
                    width: Resources.dimens.width(context) * 0.4,
                    decoration:
                        Resources.styles.kBoxBorderDecoration(radius: 7),
                    child: const Center(child: Text('Done')),
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
