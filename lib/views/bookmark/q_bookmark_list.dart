import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/bloc/subject/subject_bloc.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/model/subject_model.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/utils/admob_helper.dart';
import 'package:formula/views/01_home/home_page.dart';
import 'package:formula/views/widgets/no_data.dart';
import 'package:go_router/go_router.dart';

class QuestionBookmarkList extends StatefulWidget {
  const QuestionBookmarkList({super.key});

  @override
  State<QuestionBookmarkList> createState() => _QuestionBookmarkListState();
}

class _QuestionBookmarkListState extends State<QuestionBookmarkList> {
  AdmobHelper admobHelper = AdmobHelper();
  int selectedIndex = 0;
  String type = '';

  @override
  void initState() {
    admobHelper.createInterstitialAd();
    Future.delayed(const Duration(seconds: 2), () {
      admobHelper.loadInterstitialAd();
    });
    fetchData();
    super.initState();
  }

  fetchData() {
    BlocProvider.of<QuestionsBloc>(context).add(QuestionsGetEvent(
        quizId: '',
        idList: PrefService.getBookmarkedQuestions(type: type),
        type: type));
  }

  @override
  Widget build(BuildContext context) {
    print(
        'getBookmarkedQuestions${PrefService.getBookmarkedQuestions(type: type)}');
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Bookmark List",
              style: Resources.styles
                  .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.tertiaryFixed,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(55.0),
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                height: 45.0,
                margin: EdgeInsets.only(bottom: 7),
                child: BlocConsumer<SubjectBloc, SubjectState>(
                  listener: (context, state) {
                    print("listener State : $state");
                  },
                  builder: (context, state) {
                    print("builder State : $state");
                    if (state is SubjectGetState) {
                      List<SubjectModel> data = state.subjects
                          .where((subject) =>
                              subject.title
                                  .toString()
                                  .toLowerCase()
                                  .contains("quiz") ||
                              subject.title
                                  .toString()
                                  .toLowerCase()
                                  .contains("pyq"))
                          .toList();

                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                selectedIndex = index;

                                if (data[index].title == "Quiz") {
                                  type = "";
                                } else if (data[index]
                                    .title
                                    .toString()
                                    .toLowerCase()
                                    .contains('pyq')) {
                                  type = data[index]
                                      .title
                                      .toString()
                                      .toLowerCase()
                                      .split(' ')[0];
                                }
                                print("myType : $type");
                                fetchData();
                                setState(() {});
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 7),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: selectedIndex != index
                                          ? const Color(0xff006973)
                                          : const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          width: 1)),
                                  child: Center(
                                      child: Text(
                                    '${data[index].title}',
                                    style: Resources.styles
                                        .kTextStyle18B5(Colors.black),
                                  ))),
                            );
                          });
                    }
                    return const SizedBox();
                  },
                ),
              ),
            )),
        body: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            if (kDebugMode) {
              print("state $state ");
            }
            if (state is QuestionsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuestionsErrorState) {
              return Center(
                child: Text(state.e),
              );
            } else if (state is QuestionsGetState) {
              if (kDebugMode) {
                print("state.questions : ${state.questions}");
              }
              if (state.questions.isEmpty) {
                return NoData();
              } else {
                return ListView.builder(
                    itemCount: state.questions.length,
                    itemBuilder: (context, index) {
                      var data = state.questions[index];
                      return InkWell(
                        onTap: () async {
                          await GoRouter.of(context).pushNamed(
                              RoutesName.qBookmarkDetailsRoute,
                              extra: {
                                'id': data.id.toString(),
                                'type': type,
                              }).then((v) {
                            fetchData();
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            decoration: Resources.styles
                                .kBoxBorderDecorationR3B(context),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        Resources.dimens.width(context) * 0.7,
                                    child: HtmlWidget(
                                        "${selectedLanguage == LanguageEnums.hindi ? data.question_hi : data.question}")),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      PrefService.removeBookmarkQuestionId(
                                          data.id.toString());

                                      fetchData();
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
