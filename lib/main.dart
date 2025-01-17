import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/pdf_category/pdf_bloc.dart';
import 'package:formula/bloc/pdf_category/pdf_category_bloc.dart';
import 'package:formula/bloc/questions/questions_bloc.dart';
import 'package:formula/bloc/quizzes/countdown_time_bloc.dart';
import 'package:formula/bloc/quizzes/quizzes_bloc.dart';
import 'package:formula/bloc/sub_topic/sub_topic_bloc.dart';
import 'package:formula/bloc/subject/subject_bloc.dart';
import 'package:formula/bloc/theme/theme_bloc.dart';
import 'package:formula/bloc/topic/topic_bloc.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/res/strings.dart';
import 'package:formula/res/theme.dart';
import 'package:formula/routes/routes.dart';
import 'package:formula/utils/admob_helper.dart';
import 'package:formula/utils/utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // admob ad init
  AdmobHelper.initialization();
  // firebase crashlytics init
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // sharedPreferences init
  await PrefService.init();

  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(AppStrings.oneSignalAppId);

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  // IN APP UPDATE
  AppUtils().checkForUpdates();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SubjectBloc()),
          BlocProvider(create: (_) => TopicBloc()),
          BlocProvider(create: (_) => SubTopicBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => LanguageBloc()),
          BlocProvider(create: (_) => QuizzesBloc()),
          BlocProvider(create: (_) => QuestionsBloc()),
          BlocProvider(create: (_) => CountDownTimerBloc()),
          BlocProvider(create: (_) => PdfBloc()),
          BlocProvider(create: (_) => PdfCategoryBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            TextTheme textTheme = createTextTheme(context, "Lato", "Lato");
            MaterialTheme theme = MaterialTheme(textTheme);
            bool isDark = PrefService().getThemeMode() ?? false;
            if (state is ThemeChangeState) {
              isDark = state.isDark;
              PrefService().setThemeMode(isDark);
            }
            return MaterialApp.router(
              title: 'Math Formula',
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              theme: !isDark ? theme.light() : theme.dark(),
              routeInformationParser: AppRoutes.router.routeInformationParser,
              routerDelegate: AppRoutes.router.routerDelegate,
              routeInformationProvider:
                  AppRoutes.router.routeInformationProvider,
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}
