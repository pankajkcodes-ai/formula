import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/res/resources.dart';

class QuestionBookmarkDetails extends StatefulWidget {
  final String id;

  const QuestionBookmarkDetails({super.key, required this.id});

  @override
  State<QuestionBookmarkDetails> createState() =>
      _QuestionBookmarkDetailsState();
}

class _QuestionBookmarkDetailsState extends State<QuestionBookmarkDetails> {
  @override
  void initState() {
    BlocProvider.of<QuestionsBloc>(context)
        .add(QuestionsGetEvent(quizId: '', idList: [widget.id.toString()]));
    super.initState();
  }

  bool isAnswered = false;

  Map<int, String> selectedOptionIndices = {};
  var totalQuestions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiaryFixed,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Text("Bookmark Details",
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: BlocConsumer<QuestionsBloc, QuestionsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print("State : $state");

          if (state is QuestionsGetState) {
            totalQuestions = state.questions;
          }
          int index = 0;
          print("totalQuestions : $totalQuestions");

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              Card(
                clipBehavior: Clip.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.0,
                    )),
                child: Container(
                  width: Resources.dimens.width(context),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  clipBehavior: Clip.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      )),
                  color: selectedOptionIndices.containsKey(index) &&
                          totalQuestions[index].correctOption == "optionA"
                      ? Colors.green
                      : selectedOptionIndices[index] == "optionA" &&
                              selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption != "optionA"
                          ? Colors.red
                          : Theme.of(context).colorScheme.surfaceContainerLow,
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
                  clipBehavior: Clip.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      )),
                  color: selectedOptionIndices.containsKey(index) &&
                          totalQuestions[index].correctOption == "optionB"
                      ? Colors.green
                      : selectedOptionIndices[index] == "optionB" &&
                              selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption != "optionB"
                          ? Colors.red
                          : Theme.of(context).colorScheme.surfaceContainerLow,
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
                  clipBehavior: Clip.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      )),
                  color: selectedOptionIndices.containsKey(index) &&
                          totalQuestions[index].correctOption == "optionC"
                      ? Colors.green
                      : selectedOptionIndices[index] == "optionC" &&
                              selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption != "optionC"
                          ? Colors.red
                          :Theme.of(context).colorScheme.surfaceContainerLow,
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
                  clipBehavior: Clip.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      )),
                  color: selectedOptionIndices.containsKey(index) &&
                          totalQuestions[index].correctOption == "optionD"
                      ? Colors.green
                      : selectedOptionIndices[index] == "optionD" &&
                              selectedOptionIndices.containsKey(index) &&
                              totalQuestions[index].correctOption != "optionD"
                          ? Colors.red
                          : Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: HtmlWidget(totalQuestions[index].optionD,
                    ),
                  ),
                ),
              ),
              isAnswered
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Solution  : ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green,
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: Resources.dimens.width(context),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: HtmlWidget(totalQuestions[index].solution,),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
      bottomNavigationBar:GestureDetector(
        onTap: (){
      setState(() {
                 selectedOptionIndices [ 0] = totalQuestions[0].correctOption;
                isAnswered = !isAnswered;
              });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          height: Resources.dimens.height(context) * 0.06,
          width: Resources.dimens.width(context) ,
          decoration: Resources.styles.kBoxBorderDecorationR3(context),
          child: Center(child: Text(
              'View Solution',
              style: Resources.styles.kTextStyle14(Theme.of(context).colorScheme.tertiaryFixed))),
        ),
      ),
    );
  }
}
