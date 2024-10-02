import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:go_router/go_router.dart';

class QuestionBookmarkList extends StatefulWidget {
  const QuestionBookmarkList({super.key});

  @override
  State<QuestionBookmarkList> createState() => _QuestionBookmarkListState();
}

class _QuestionBookmarkListState extends State<QuestionBookmarkList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuestionsBloc>(context).add(QuestionsGetEvent(
        quizId: '', idList: PrefService.getBookmarkedQuestions()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title:  Text("Bookmark List",  style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            print("state $state ");
            if (state is QuestionsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuestionsErrorState) {
              return Center(
                child: Text(state.e),
              );
            } else if (state is QuestionsGetState) {
              print("state.questions : ${state.questions}");
              if (state.questions.isEmpty) {
                return const Center(child: Text("No Data"));
              } else {
                return ListView.builder(
                    itemCount: state.questions.length,
                    itemBuilder: (context, index) {
                      var data = state.questions[index];
                      return InkWell(
                        onTap: () async {
                          await GoRouter.of(context)
                              .pushNamed(RoutesName.qBookmarkDetailsRoute,
                                  extra: data.id.toString())
                              .then((v) {
                            BlocProvider.of<QuestionsBloc>(context).add(
                                QuestionsGetEvent(
                                    quizId: '',
                                    idList:
                                        PrefService.getBookmarkedQuestions()));
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        Resources.dimens.width(context) * 0.7,
                                    child: HtmlWidget("${data.question}")),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      PrefService.removeBookmarkQuestionId(
                                          data.id.toString());
                                      BlocProvider.of<QuestionsBloc>(context)
                                          .add(QuestionsGetEvent(
                                              quizId: '',
                                              idList: PrefService
                                                  .getBookmarkedQuestions()));
                                    },
                                    icon: const Icon(Icons.bookmark))
                              ],
                            )),
                      );
                    });
              }
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
