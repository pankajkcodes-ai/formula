
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/subject/subject_bloc.dart';
import 'package:formula/bloc/theme/theme_bloc.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/res/app_urls.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/utils/admob_helper.dart';
import 'package:formula/views/menu/drawer_menu.dart';
import 'package:formula/views/widgets/ad_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdmobHelper admobHelper = AdmobHelper();

  BannerAd? _bannerAd;

  final PrefService _prefService = PrefService();

  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = AdmobHelper.getBannerAd()..load();
  }

  @override
  void initState() {
    context.read<SubjectBloc>().add(SubjectGetEvent());

    _setLanguage();
    loadAd();
    super.initState();
  }

  void _setLanguage() {
    String? language = _prefService.getLanguage();

    if (language == "_hi") {
      selectedLanguage = LanguageEnums.hindi;
    } else {
      selectedLanguage = LanguageEnums.english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiaryFixed,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: Resources.dimens.height(context) * 0.08,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: IconButton(
                onPressed: () {
                  Theme.of(context).brightness == Brightness.dark
                      ? context
                          .read<ThemeBloc>()
                          .add(ThemeChangeEvent(isDark: false))
                      : context
                          .read<ThemeBloc>()
                          .add(ThemeChangeEvent(isDark: true));
                },
                icon: Icon(Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
              print("language State : $state");
              if (state is LanguageChangeState) {
                selectedLanguage =
                    state.language; // Access selected language from state
              }

              return IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return BlocBuilder<LanguageBloc, LanguageState>(
                              builder: (context, state) {
                            if (state is LanguageChangeState) {
                              selectedLanguage = state
                                  .language; // Access selected language from state
                            }
                            return AlertDialog(
                              content: SizedBox(
                                height: Resources.dimens.height(context) * 0.13,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('English'),
                                      leading: Radio(
                                        value: LanguageEnums.english,
                                        groupValue: selectedLanguage,
                                        onChanged: (LanguageEnums? value) {
                                          _prefService.setLanguage("");

                                          context.read<LanguageBloc>().add(
                                              LanguageChangeEvent(
                                                  language:
                                                      LanguageEnums.english));
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Hindi'),
                                      leading: Radio(
                                        value: LanguageEnums.hindi,
                                        groupValue: selectedLanguage,
                                        onChanged: (LanguageEnums? value) {
                                          _prefService.setLanguage("_hi");

                                          context.read<LanguageBloc>().add(
                                              LanguageChangeEvent(
                                                  language:
                                                      LanguageEnums.hindi));
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  icon: Image.asset(
                    selectedLanguage == LanguageEnums.hindi
                        ? "assets/icons/translate.png"
                        : "assets/icons/translate-reverse.png",
                    height: 23,
                    color: Colors.white,
                  ));
            }),
          )
        ],
        title: Text(
          Resources.strings.appName,
          textAlign: TextAlign.center,
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BlocConsumer<SubjectBloc, SubjectState>(
                listener: (context, state) {
                  print("listener State : $state");
                },
                builder: (context, state) {
                  print("builder State : $state");
                  if (state is SubjectErrorState) {
                    return const HomeShimmer();
                  } else if (state is SubjectLoadingState) {
                    return const HomeShimmer();
                  } else if (state is SubjectGetState) {
                    var data = state;

                    return Expanded(
                      flex: 1,
                      child: GridView.builder(
                          itemCount: data.subjects.length + 2,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 15),
                          itemBuilder: (BuildContext context, int index) {
                            if (index < data.subjects.length - 1) {
                              return GestureDetector(
                                onTap: () {
                                  /// navigate based on the index
                                  print(
                                      "data.subjects : ${data.subjects[index]}");

                                  if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("quiz")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.quizListRoute,
                                      extra: '',
                                    );
                                  } else if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("cbse")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.quizListRoute,
                                      extra: 'cbse',
                                    );
                                  } else if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("up")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.quizListRoute,
                                      extra: 'up',
                                    );
                                  } else if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("bseb")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.quizListRoute,
                                      extra: 'bseb',
                                    );
                                  } else if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("bser")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.quizListRoute,
                                      extra: 'bser',
                                    );
                                  } else if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("unit converter")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.htmlViewRoute,
                                      extra: {
                                        "url":
                                            "https://examtest.in/formula/public/unit-converter/",
                                        "title": "Unit Converter",
                                      },
                                    );
                                  } else if (data.subjects[index].title
                                      .toString()
                                      .toLowerCase()
                                      .contains("formula")) {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.topicsRoute,
                                      extra: data.subjects[index],
                                    );
                                  } else {
                                    GoRouter.of(context).pushNamed(
                                      RoutesName.comingSoonScreenRoute,
                                      extra: data.subjects[index],
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: index == 1
                                          ? const Color(0xffF0FFC3)
                                          : index == 2
                                              ? const Color(0xffE09DFF)
                                              : index == 3
                                                  ? const Color(0xffc99dff)
                                                  : index == 4
                                                      ? const Color(0xff9d96f8)
                                                      : const Color(0xff9EFFFA),
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Image.network(
                                            height: 70,
                                            width: 100,
                                            "${AppUrls.baseUrl}/${data.subjects[index].icon}"),
                                      ),
                                      SizedBox(
                                        height:
                                            Resources.dimens.height(context) *
                                                0.01,
                                      ),
                                      BlocBuilder<LanguageBloc, LanguageState>(
                                          builder: (context, state) {
                                        return Text(
                                            selectedLanguage ==
                                                    LanguageEnums.hindi
                                                ? data.subjects[index].title_hi
                                                    .toString()
                                                : data.subjects[index].title
                                                    .toString(),
                                            style: Resources.styles
                                                .kTextStyle15B6(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .scrim));
                                      })
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (index == data.subjects.length - 1) {
                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                    RoutesName.pyqListRoute,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffff9c8b),
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(11),
                                        child: Image.asset(
                                            filterQuality: FilterQuality.high,
                                            height: 77,
                                            Resources.images.bookIcon),
                                      ),
                                      SizedBox(
                                        height:
                                            Resources.dimens.height(context) *
                                                0.01,
                                      ),
                                      BlocBuilder<LanguageBloc, LanguageState>(
                                          builder: (context, value) {
                                        return Text(
                                            selectedLanguage ==
                                                    LanguageEnums.hindi
                                                ? "पिछले वर्ष की प्रश्नोत्तरी"
                                                : "Previous Year Quiz",
                                            style: Resources.styles
                                                .kTextStyle15B6(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .scrim));
                                      })
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (index == data.subjects.length) {
                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      RoutesName.pdfCategoryListRoute);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff8beeff),
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(11),
                                        child: Image.asset(
                                            filterQuality: FilterQuality.high,
                                            height: 75,
                                            Resources.images.pdfIcon),
                                      ),
                                      SizedBox(
                                        height:
                                            Resources.dimens.height(context) *
                                                0.01,
                                      ),
                                      BlocBuilder<LanguageBloc, LanguageState>(
                                          builder: (context, value) {
                                        return Text(
                                            selectedLanguage ==
                                                    LanguageEnums.hindi
                                                ? "Math PDF"
                                                : "Math PDF",
                                            style: Resources.styles
                                                .kTextStyle15B6(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .scrim));
                                      })
                                    ],
                                  ),
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  RoutesName.qBookmarkListRoute,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                    color: const Color(0xffffee8b),
                                    borderRadius: BorderRadius.circular(11),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        width: 2)),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(11),
                                      child: Image.asset(
                                          filterQuality: FilterQuality.high,
                                          height: 75,
                                          Resources.images.bookmarkIcon),
                                    ),
                                    SizedBox(
                                      height: Resources.dimens.height(context) *
                                          0.01,
                                    ),
                                    BlocBuilder<LanguageBloc, LanguageState>(
                                        builder: (context, value) {
                                      return Text(
                                          selectedLanguage ==
                                                  LanguageEnums.hindi
                                              ? "बुकमार्क"
                                              : "Bookmarks",
                                          style: Resources.styles
                                              .kTextStyle15B6(Theme.of(context)
                                                  .colorScheme
                                                  .scrim));
                                    })
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const HomeShimmer();
                },
              ),
              const MyBannerAd(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GridView.builder(
          itemCount: 6,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              childAspectRatio: 1,
              crossAxisSpacing: 15),
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              baseColor: const Color(0xff006973),
              highlightColor: Colors.grey[200]!,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11), color: Colors.red),
              ),
            );
          }),
    );
  }
}
