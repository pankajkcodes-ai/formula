import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/topic/topic_bloc.dart';
import 'package:formula/model/subject_model.dart';
import 'package:formula/res/resources.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes_path.dart';

class Topics extends StatefulWidget {
  const Topics({super.key, required this.subjectModel});

  final SubjectModel subjectModel;

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  List<Map<String, dynamic>> topicList = [
    {"number": "1 )", "title": 'ALGEBRA'},
    {"number": "2 )", "title": 'MENSURATION (2D)'},
    {"number": "3 )", "title": 'MENSURATION (3D)'},
    {"number": "4 )", "title": 'GEOMETRY'},
    {"number": "5 )", "title": 'CO-ORDINATE GEOMETRY'},
    {"number": "6 )", "title": 'TRIGONOMETRY'},
    {"number": "7 )", "title": "HEIGHT & DISTANCE"},
    {"number": "8 )", "title": "TIME & DISTANCE"},
    {"number": "9 )", "title": "NUMBER SYSTEM"},
    {"number": "10 )", "title": "BOAT & STREAM"},
    {"number": "11 )", "title": "RATIO & PROPORTION"},
    {"number": "12 )", "title": "ALLIGATION"},
    {"number": "13 )", "title": "AVERAGE"},
    {"number": "14 )", "title": "TIME & WORK"},
    {"number": "15 )", "title": "PERCENTAGE"},
    {"number": "16 )", "title": "PROFIT & LOSS"},
    {"number": "17 )", "title": "SIMPLE & COMPOUND INTEREST"},
    {"number": "18 )", "title": "STATISTICS"},
  ];

  @override
  void initState() {
    context
        .read<TopicBloc>()
        .add(TopicGetEvent(subject: widget.subjectModel.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiaryFixed,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: Resources.dimens.height(context) * 0.08,
        title: Text(
          widget.subjectModel.title.toString(),
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: BlocBuilder<TopicBloc, TopicState>(
          builder: (context, state) {
            if (kDebugMode) {
              print("State : $state");
            }
            if (state is TopicGetState) {
              var data = state;
              return GridView.builder(
                  itemCount: data.topics.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.9),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RoutesName.subTopicsRoute,
                            extra: data.topics[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration:
                              Resources.styles.kBoxBorderDecorationR3(context),
                          child: Row(
                            children: [
                              Text(
                                "(${index + 1})",
                                style: Resources.styles.kTextStyle14(
                                    Theme.of(context)
                                        .colorScheme
                                        .tertiaryFixed),
                              ),
                              SizedBox(
                                width: Resources.dimens.width(context) * 0.02,
                              ),
                              Expanded(
                                child: Text(
                                  selectedLanguage==LanguageEnums.hindi?data.topics[index].title_hi.toString() :data.topics[index].title.toString() ,
                                  style: Resources.styles.kTextStyle12B5(
                                      Theme.of(context)
                                          .colorScheme
                                          .tertiaryFixed),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )),
                    );
                  });
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
