import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/sub_topic/sub_topic_bloc.dart';
import 'package:formula/model/topic_model.dart';
import 'package:formula/res/app_urls.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:go_router/go_router.dart';

class SubTopics extends StatefulWidget {
  final TopicModel topicModel;

  const SubTopics({super.key, required this.topicModel});

  @override
  State<SubTopics> createState() => _SubTopicsState();
}

class _SubTopicsState extends State<SubTopics> {
  @override
  void initState() {
    context
        .read<SubTopicBloc>()
        .add(SubTopicGetEvent(topicModel: widget.topicModel));
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
          "${widget.topicModel.title}",
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: BlocBuilder<SubTopicBloc, SubTopicState>(
          builder: (context, state) {
            if (state is SubTopicGetState) {
              if (kDebugMode) {
                print("State : $state");
              }
              var data = state;
              return ListView.builder(
                  itemCount: data.subTopics.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed(RoutesName.htmlViewRoute, extra: {
                          "url":
                              "${AppUrls.baseUrl}/view-html.php?id=${data.subTopics[index].id}",
                          "title": data.subTopics[index].title.toString()
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration:
                            Resources.styles.kBoxBorderDecorationR3(context),
                        child: Row(
                          children: [
                            Text(
                              "${index + 1}.",
                              style: Resources.styles.kTextStyle12B5(
                                  Theme.of(context).colorScheme.tertiaryFixed),
                            ),
                            SizedBox(
                              width: Resources.dimens.width(context) * 0.02,
                            ),
                            SizedBox(
                              width: Resources.dimens.width(context) * 0.7,
                              child: Text(
                                selectedLanguage == LanguageEnums.hindi
                                    ? data.subTopics[index].title_hi.toString()
                                    : data.subTopics[index].title.toString(),
                                style: Resources.styles.kTextStyle12B5(
                                    Theme.of(context)
                                        .colorScheme
                                        .tertiaryFixed),
                              ),
                            ),
                          ],
                        ),
                      ),
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
