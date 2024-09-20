import 'package:flutter/material.dart';
import 'package:formula/model/result_model.dart';

class ResultSummary extends StatefulWidget {
  final ResultModel resultSummary;
  const ResultSummary({super.key, required this.resultSummary});

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
            child: ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text('Total Marks'),
              trailing: Text('${widget.resultSummary.totalMarks}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.done),
              title: const Text('Your Marks'),
              trailing: Text('${widget.resultSummary.obtainMarks}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text('Total Questions'),
              trailing: Text('${widget.resultSummary.totalQuestions}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.done),
              title: const Text('Correct Answers'),
              trailing: Text('${widget.resultSummary.correctAnswers}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Wrong Answers'),
              trailing: Text('${widget.resultSummary.wrongAnswers}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Not Answered'),
              trailing: Text('${widget.resultSummary.notAttempt}'),
            ),
          ),
        ],
      ),
    );
  }
}
