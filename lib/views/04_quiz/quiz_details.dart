import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/model/result_model.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/utils/utils.dart';
import 'package:go_router/go_router.dart';

class QuizDetails extends StatefulWidget {
  final QuizzesModel quizzesModel;

  const QuizDetails({super.key, required this.quizzesModel});

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedQuestionIndex = 0;
  Map<int, int> selectedOptionIndices = {};

  late PageController _pageController;

  Timer? _timer;
  int _start = 1800;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context
        .read<QuestionsBloc>()
        .add(QuestionsGetEvent(quizId: widget.quizzesModel.id!));
    _start = int.parse(widget.quizzesModel.totalTime!) * 60;
    startTimer();
    _pageController = PageController(initialPage: 0);
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
                                const CircleAvatar(
                                  backgroundColor: Colors.grey,
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
                                  crossAxisCount: 5,
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
                                    : Colors.grey,
                                radius: 15,
                                child: Text('${index + 1}'),
                              ),
                            );
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RoutesName.resultSummaryRoute,
                            extra: ResultModel(
                                totalMarks: double.parse(
                                    widget.quizzesModel.totalPoints.toString()),
                                obtainMarks: 5,
                                percentage: 2,
                                totalQuestions: int.parse(widget
                                    .quizzesModel.totalQuestions
                                    .toString()),
                                correctAnswers: 4,
                                wrongAnswers: 2,
                                notAttempt: 1,
                                totalTime: 40));
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: Resources.styles.kBoxBorderDecoration(),
                        width: Resources.dimens.width(context),
                        height: Resources.dimens.height(context) * 0.05,
                        child: const Center(child: Text('Submit')),
                      ),
                    ),
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
                      print("select : $selectedOptionIndices");
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
                SizedBox(
                  width: Resources.dimens.width(context) * 0.05,
                ),
                totalQuestions.length - 1 == selectedQuestionIndex
                    ? GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                              RoutesName.resultSummaryRoute,
                              extra: ResultModel(
                                  totalMarks: double.parse(widget
                                      .quizzesModel.totalPoints
                                      .toString()),
                                  obtainMarks: 5,
                                  percentage: 2,
                                  totalQuestions: int.parse(widget
                                      .quizzesModel.totalQuestions
                                      .toString()),
                                  correctAnswers: 4,
                                  wrongAnswers: 2,
                                  notAttempt: 1,
                                  totalTime: 40));
                        },
                        child: Container(
                          height: Resources.dimens.height(context) * 0.04,
                          width: Resources.dimens.width(context) * 0.3,
                          decoration: Resources.styles.kBoxBorderDecoration(),
                          child: const Center(child: Text('Submit')),
                        ),
                      )
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
              AppUtils.formatTime(_start),
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
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedQuestionIndex = index;
                  });
                },
                child: Container(
                  width: Resources.dimens.width(context),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            width: Resources.dimens.width(context),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: HtmlWidget(totalQuestions[index].question),
                            /*  child: Text(
                                '(${index + 1}) ${totalQuestions[index].question}',
                                style: Resources.styles.kTextStyle14B(
                                    Theme.of(context)
                                        .colorScheme
                                        .onBackground)),*/
                          ),
                        ),
                        SizedBox(
                          height: Resources.dimens.height(context) * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptionIndices[index] = 0;
                            });
                          },
                          child: Card(
                            color: selectedOptionIndices[index] == 0
                                ? Colors.green
                                : Colors.transparent,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: HtmlWidget(totalQuestions[index].optionA),
                              /* child: Text(
                                'A. ${totalQuestions[index].optionA}',
                                style: Resources.styles.kTextStyle16B5(
                                    Theme.of(context).colorScheme.onBackground),
                              ),*/
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Resources.dimens.height(context) * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptionIndices[index] = 1;
                            });
                          },
                          child: Card(
                            color: selectedOptionIndices[index] == 1
                                ? Colors.green
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptionIndices[index] = 2;
                            });
                          },
                          child: Card(
                            color: selectedOptionIndices[index] == 2
                                ? Colors.green // Change color here
                                : Colors.transparent,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: HtmlWidget(totalQuestions[index].optionC),
                              /*child: Text(
                                'C. ${totalQuestions[index].optionC}',
                                style: Resources.styles.kTextStyle16B5(
                                    Theme.of(context).colorScheme.onBackground),
                              ),*/
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Resources.dimens.height(context) * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptionIndices[index] = 3;
                            });
                          },
                          child: Card(
                            color: selectedOptionIndices[index] == 3
                                ? Colors.green
                                : Colors.transparent,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: HtmlWidget(totalQuestions[index].optionD),
                              /*child: Text(
                                'D. ${totalQuestions[index].optionD}',
                              ),*/
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
