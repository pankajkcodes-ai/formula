import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/bloc/quizzes/countdown_time_bloc.dart';
import 'package:formula/data/local/database_helper.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/model/result_model.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/utils/utils.dart';
import 'package:go_router/go_router.dart';

class QuizReattempt extends StatefulWidget {
  final QuizzesModel quizzesModel;
  final bool? isReAttempt;

  const QuizReattempt(
      {super.key, required this.quizzesModel, this.isReAttempt});

  @override
  State<QuizReattempt> createState() => _QuizReattemptState();
}

class _QuizReattemptState extends State<QuizReattempt> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedQuestionIndex = 0;
  Map<int, String> selectedOptionIndices = {};

  late PageController _pageController;
  int _currentPage = 0;

  // CHECK CORRECT ANSWER
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int notAttempt = 0;
  int totalQuestions = 0;
  double totalMarks = 0;
  double obtainMarks = 0;
  double percentage = 0;
  int totalTime = 0;

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
    context.read<CountDownTimerBloc>().add(
        StartTimer(int.parse(widget.quizzesModel.totalTime.toString()) * 60));

    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                                radius: 25,
                                child: Text('${index + 1}'),
                              ),
                            );
                          }),
                    ),
                    submitButton(totalQuestions),
                  ],
                ),
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (kDebugMode) {
                        print("select : $selectedOptionIndices");
                      }
                      selectedOptionIndices.remove(selectedQuestionIndex);
                      //selectedOptionIndices.clear();
                    });
                  },
                  child: Container(
                    height: Resources.dimens.height(context) * 0.04,
                    width: Resources.dimens.width(context) * 0.3,
                    decoration: Resources.styles.kBoxBorderDecoration(),
                    child: const Center(child: Text('Clear Response')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("selectedQuestionIndex${totalQuestions.length}");
                    print("selectedQuestionIndex$selectedQuestionIndex");
                    setState(() {
                      if (totalQuestions.length > selectedQuestionIndex) {
                        selectedQuestionIndex = (selectedQuestionIndex - 1);
                      }
                    });
                    _goToPage(selectedQuestionIndex);
                  },
                  child: Container(
                    height: Resources.dimens.height(context) * 0.04,
                    width: Resources.dimens.width(context) * 0.25,
                    decoration: Resources.styles.kBoxBorderDecoration(),
                    child: const Center(child: Text('Previous')),
                  ),
                ),
                totalQuestions.length - 1 == selectedQuestionIndex
                    ? submitButton(totalQuestions)
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
                          width: Resources.dimens.width(context) * 0.25,
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
            title: BlocBuilder<CountDownTimerBloc, CountDownTimerState>(
              builder: (context, state) {
                if (kDebugMode) {
                  print("CountDownTimerBlocState : ${state.duration}");
                }
                totalTime =
                    (int.parse(widget.quizzesModel.totalTime.toString()) * 60) -
                        state.duration;

                return Text(
                  AppUtils.formatTime(state.duration),
                  style: Resources.styles.kTextStyle16B5(
                      Theme.of(context).colorScheme.onBackground),
                );
              },
            ),
            actions: [
              totalQuestions.isNotEmpty
                  ? PrefService.isQuestionBookmarked(
                          totalQuestions[_currentPage].id.toString())
                      ? IconButton(
                          onPressed: () {
                            PrefService.removeBookmarkQuestionId(
                                totalQuestions[_currentPage].id.toString());
                            setState(() {});
                          },
                          icon: const Icon(Icons.bookmark),
                        )
                      : IconButton(
                          onPressed: () {
                            PrefService.storeBookmarkQuestionId(
                                totalQuestions[_currentPage].id.toString());
                            setState(() {});
                          },
                          icon: const Icon(Icons.bookmark_border_outlined))
                  : const SizedBox.shrink(),
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
                  InkWell(
                    onTap: () {
                      if (!selectedOptionIndices.containsKey(index)) {
                        setState(() {
                          selectedOptionIndices[index] = "optionA";
                        });
                      }
                    },
                    child: Card(
                      color: selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption == "optionA"
                          ? Colors.green
                          : selectedOptionIndices[index] == "optionA" &&
                                  selectedOptionIndices.containsKey(index) &&
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
                  ),
                  SizedBox(
                    height: Resources.dimens.height(context) * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      if (!selectedOptionIndices.containsKey(index)) {
                        setState(() {
                          selectedOptionIndices[index] = "optionB";
                        });
                      }
                    },
                    child: Card(
                      color: selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption == "optionB"
                          ? Colors.green
                          : selectedOptionIndices[index] == "optionB" &&
                                  selectedOptionIndices.containsKey(index) &&
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
                  ),
                  const SizedBox(),
                  InkWell(
                    onTap: () {
                      if (!selectedOptionIndices.containsKey(index)) {
                        setState(() {
                          selectedOptionIndices[index] = "optionC";
                        });
                      }
                    },
                    child: Card(
                      color: selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption == "optionC"
                          ? Colors.green
                          : selectedOptionIndices[index] == "optionC" &&
                                  selectedOptionIndices.containsKey(index) &&
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
                  ),
                  SizedBox(
                    height: Resources.dimens.height(context) * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      if (!selectedOptionIndices.containsKey(index)) {
                        setState(() {
                          selectedOptionIndices[index] = "optionD";
                        });
                      }
                    },
                    child: Card(
                      color: selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption == "optionD"
                          ? Colors.green
                          : selectedOptionIndices[index] == "optionD" &&
                                  selectedOptionIndices.containsKey(index) &&
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
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  GestureDetector submitButton(List totalQuestions) {
    return GestureDetector(
      onTap: () async {
        // STEP 1 : SAVE QUIZ ID IN TO DATABASE
        PrefService.storeAttemptedQuizId(widget.quizzesModel.id.toString());
        // STEP 2 : SAVE ALL ANSWERS RELATED THIS QUIZ ID IN TO DATABASE

        print("selectedOptionIndices : $selectedOptionIndices");
        print("selectedOptionIndices : ${selectedOptionIndices.keys.length}");
        await QuizDatabaseHelper.insertAttempt(
            int.parse(widget.quizzesModel.id.toString()),
            selectedOptionIndices);

        print("totalQuestions : $totalQuestions");
        print("totalQuestions : ${totalQuestions.length}");
        var notAttempt =
            totalQuestions.length - selectedOptionIndices.keys.length;

        var correctAnswers = 0;
        var wrongAnswers = 0;
        for (var e in selectedOptionIndices.entries) {
          print("e : ${e.key} : ${e.value}");
          if (e.value == totalQuestions[e.key].correctOption) {
            correctAnswers++;
          } else {
            wrongAnswers++;
          }
        }

        double obtainMarks =
            (double.parse(widget.quizzesModel.totalPoints.toString()) /
                    int.parse(widget.quizzesModel.totalQuestions.toString())) *
                correctAnswers;

        context.read<CountDownTimerBloc>().add(ResetTimer());

        GoRouter.of(context).pushNamed(RoutesName.resultSummaryRoute, extra: {
          "resultModel": ResultModel(
              totalMarks:
                  double.parse(widget.quizzesModel.totalPoints.toString()),
              obtainMarks: obtainMarks,
              percentage: obtainMarks * 100 / totalMarks,
              totalQuestions:
                  int.parse(widget.quizzesModel.totalQuestions.toString()),
              correctAnswers: correctAnswers,
              wrongAnswers: wrongAnswers,
              notAttempt: notAttempt,
              totalTime: totalTime,
              selectedOptionIndices: selectedOptionIndices),
          "quizModel": widget.quizzesModel
        });
      },
      child: Container(
        height: Resources.dimens.height(context) * 0.04,
        width: Resources.dimens.width(context) * 0.3,
        decoration: Resources.styles.kBoxBorderDecoration(),
        child: const Center(child: Text('Submit')),
      ),
    );
  }
}
