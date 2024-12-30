import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/subject/subject_bloc.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/views/widgets/list_shimmer.dart';
import 'package:go_router/go_router.dart';

class PyqList extends StatefulWidget {
  const PyqList({super.key});

  @override
  State<PyqList> createState() => _PyqListState();
}

class _PyqListState extends State<PyqList> {
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
          'Previous Year Quiz',
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: BlocConsumer<SubjectBloc, SubjectState>(
          listener: (context, state) {
            print("listener State : $state");
          },
          builder: (context, state) {
            print("builder State : $state");
            if (state is SubjectErrorState) {
              return const ListShimmer();
            } else if (state is SubjectLoadingState) {
              return const ListShimmer();
            } else if (state is SubjectGetState) {
              var data = state.subjects
                  .where((e) =>
                      e.title.toString().toLowerCase().contains('pyq') ||
                      e.title
                          .toString()
                          .toLowerCase()
                          .contains('previous year paper') ||
                      e.title
                          .toString()
                          .toLowerCase()
                          .contains('previous year question paper'))
                  .toList();

              return ListView.builder(
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        /// navigate based on the index
                        print("data.subjects : ${data[index]}");

                        if (data[index]
                            .title
                            .toString()
                            .toLowerCase()
                            .contains("quiz")) {
                          GoRouter.of(context).pushNamed(
                            RoutesName.quizListRoute,
                            extra: '',
                          );
                        } else if (data[index]
                            .title
                            .toString()
                            .toLowerCase()
                            .contains("cbse")) {
                          GoRouter.of(context).pushNamed(
                            RoutesName.quizListRoute,
                            extra: 'cbse',
                          );
                        } else if (data[index]
                            .title
                            .toString()
                            .toLowerCase()
                            .contains("up")) {
                          GoRouter.of(context).pushNamed(
                            RoutesName.quizListRoute,
                            extra: 'up',
                          );
                        } else if (data[index]
                            .title
                            .toString()
                            .toLowerCase()
                            .contains("bseb")) {
                          GoRouter.of(context).pushNamed(
                            RoutesName.quizListRoute,
                            extra: 'bseb',
                          );
                        } else if (data[index]
                            .title
                            .toString()
                            .toLowerCase()
                            .contains("bser")) {
                          GoRouter.of(context).pushNamed(
                            RoutesName.quizListRoute,
                            extra: 'bser',
                          );
                        } else {
                          GoRouter.of(context).pushNamed(
                            RoutesName.comingSoonScreenRoute,
                            extra: data[index],
                          );
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
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 10),
                          /*    leading: Image.network(
                              height: 50,
                              "${AppUrls.baseUrl}/${data[index].icon}"),*/
                          title: SizedBox(
                            width: Resources.dimens.width(context) * 0.7,
                            child: Text(
                              selectedLanguage == LanguageEnums.hindi
                                  ? data[index].title_hi.toString()
                                  : data[index].title.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const ListShimmer();
          },
        ),
      ),
    );
  }
}
