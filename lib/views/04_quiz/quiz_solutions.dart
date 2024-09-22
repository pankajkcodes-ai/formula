import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/model/result_model.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/utils/utils.dart';
import 'package:go_router/go_router.dart';

class QuizSolutions extends StatefulWidget {
  final QuizzesModel quizzesModel;
  final ResultModel resultModel;

  const QuizSolutions(
      {super.key, required this.quizzesModel, required this.resultModel});

  @override
  State<QuizSolutions> createState() => _QuizSolutionsState();
}

class _QuizSolutionsState extends State<QuizSolutions> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedQuestionIndex = 0;
  Map<int, String> selectedOptionIndices = {};

  late PageController _pageController;

  // CHECK CORRECT ANSWER
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int notAttempt = 0;
  int totalQuestions = 0;
  double totalMarks = 0;
  double obtainMarks = 0;
  double percentage = 0;
  String totalTime = '';

  void calculateResult() {}

  void resetQuiz() {
    setState(() {
      selectedOptionIndices.clear();
      _pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    super.initState();
    context
        .read<QuestionsBloc>()
        .add(QuestionsGetEvent(quizId: widget.quizzesModel.id!));
    // startTimer();
    _pageController = PageController(initialPage: 0);
    selectedOptionIndices = widget.resultModel.selectedOptionIndices;
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print("State : $state");
        var totalQuestions = [];
        if (state is QuestionsGetState) {
          totalQuestions = state.questions;
        }

        print("totalQuestions : $totalQuestions");

        return Scaffold(
          key: scaffoldKey,
          endDrawer: Drawer(
              width: Resources.dimens.width(context) * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: Resources.dimens.height(context) * 0.05,
                      width: Resources.dimens.width(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.greenAccent,
                                ),
                                SizedBox(
                                  width: Resources.dimens.width(context) * 0.02,
                                ),
                                const Text('Attempt')
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade400,
                                  radius: 10,
                                ),
                                SizedBox(
                                  width: Resources.dimens.width(context) * 0.02,
                                ),
                                const Text('Not Attempt')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 10,
                          ),
                          SizedBox(
                            width: Resources.dimens.width(context) * 0.02,
                          ),
                          const Text('Current')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Resources.dimens.height(context) * 0.00,
                    ),
                    Expanded(
                      flex: 1,
                      child: GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: totalQuestions.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.4),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                selectedQuestionIndex = index;
                                setState(() {});
                                _goToPage(selectedQuestionIndex);
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedQuestionIndex == index
                                    ? Colors.blue
                                    : selectedOptionIndices.containsKey(index)
                                        ? Colors.greenAccent
                                        : Colors.grey.shade400,
                                child: Text('${index + 1}'),
                              ),
                            );
                          }),
                    ),
                    doneButton(),
                  ],
                ),
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (totalQuestions.length > selectedQuestionIndex) {
                        selectedQuestionIndex = (selectedQuestionIndex - 1);
                      }
                    });
                    _goToPage(selectedQuestionIndex);
                  },
                  child: Container(
                    height: Resources.dimens.height(context) * 0.04,
                    width: Resources.dimens.width(context) * 0.3,
                    decoration: Resources.styles.kBoxBorderDecoration(),
                    child: const Center(child: Text('Previous')),
                  ),
                ),
                SizedBox(
                  width: Resources.dimens.width(context) * 0.05,
                ),
                totalQuestions.length - 1 == selectedQuestionIndex
                    ? doneButton()
                    : GestureDetector(
                        onTap: () {
                          print(
                              "selectedQuestionIndex${totalQuestions.length}");
                          print("selectedQuestionIndex$selectedQuestionIndex");
                          setState(() {
                            if (totalQuestions.length > selectedQuestionIndex) {
                              selectedQuestionIndex =
                                  (selectedQuestionIndex + 1);
                            }
                          });
                          _goToPage(selectedQuestionIndex);
                        },
                        child: Container(
                          height: Resources.dimens.height(context) * 0.04,
                          width: Resources.dimens.width(context) * 0.3,
                          decoration: Resources.styles.kBoxBorderDecoration(),
                          child: const Center(child: Text('Next')),
                        ),
                      ),
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.onBackground),
            title: Text(
              "Total time : ${AppUtils.formatTime(widget.resultModel.totalTime)}",
              style: Resources.styles
                  .kTextStyle16B5(Theme.of(context).colorScheme.onBackground),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: const Icon(Icons.menu)),
            ],
          ),
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: totalQuestions.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  Card(
                    child: Container(
                      width: Resources.dimens.width(context),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: HtmlWidget(totalQuestions[index].question),
                    ),
                  ),
                  SizedBox(
                    height: Resources.dimens.height(context) * 0.02,
                  ),
                  Card(
                    color: selectedOptionIndices[index] == "optionA" &&
                            totalQuestions[index].correctOption == "optionA"
                        ? Colors.green
                        : selectedOptionIndices[index] == "optionA" &&
                                totalQuestions[index].correctOption !=
                                    "optionA"
                            ? Colors.red
                            : Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: HtmlWidget(totalQuestions[index].optionA),
                    ),
                  ),
                  SizedBox(
                    height: Resources.dimens.height(context) * 0.01,
                  ),
                  Card(
                    color: selectedOptionIndices[index] == "optionB" &&
                            totalQuestions[index].correctOption == "optionB"
                        ? Colors.green
                        : selectedOptionIndices[index] == "optionB" &&
                                totalQuestions[index].correctOption !=
                                    "optionB"
                            ? Colors.red
                            : Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: HtmlWidget(totalQuestions[index].optionB),
                      /*child: Text(
                        'B. ${totalQuestions[index].optionB}',
                      ),*/
                    ),
                  ),
                  const SizedBox(),
                  Card(
                    color: selectedOptionIndices[index] == "optionC" &&
                            totalQuestions[index].correctOption == "optionC"
                        ? Colors.green
                        : selectedOptionIndices[index] == "optionC" &&
                                totalQuestions[index].correctOption !=
                                    "optionC"
                            ? Colors.red
                            : Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: HtmlWidget(totalQuestions[index].optionC),
                    ),
                  ),
                  SizedBox(
                    height: Resources.dimens.height(context) * 0.01,
                  ),
                  Card(
                    color: selectedOptionIndices[index] == "optionD" &&
                            totalQuestions[index].correctOption == "optionD"
                        ? Colors.green
                        : selectedOptionIndices[index] == "optionD" &&
                                totalQuestions[index].correctOption !=
                                    "optionD"
                            ? Colors.red
                            : Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: HtmlWidget(totalQuestions[index].optionD),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Solution  : ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: Resources.dimens.width(context),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: HtmlWidget(totalQuestions[index].solution),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  GestureDetector doneButton() {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        height: Resources.dimens.height(context) * 0.04,
        width: Resources.dimens.width(context) * 0.3,
        decoration: Resources.styles.kBoxBorderDecoration(),
        child: const Center(child: Text('Done')),
      ),
    );
  }
}
