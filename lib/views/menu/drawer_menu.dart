import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.zero, // Rectangular shape with zero border radius
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              onTap: () {
                GoRouter.of(context).push(RoutesName.notificationRoute);
              },
              leading: const Icon(
                Icons.notifications_none,
              ),
              title: const Text(
                'Notification',
              ),
            ),
            ListTile(
              onTap: () {
                GoRouter.of(context).push(RoutesName.feedbackRoute);
              },
              leading: const Icon(
                Icons.chat_outlined,
              ),
              title: const Text(
                'Feedback',
              ),
            ),
            ListTile(
              onTap: () async {
                final InAppReview inAppReview = InAppReview.instance;
                await inAppReview.isAvailable().then((isAvailable) {

                  print("isAvailable :$isAvailable");
                  if (isAvailable) {
                    // Future.delayed(const Duration(seconds: 2), () {
                    //   try {
                    //     inAppReview.requestReview();
                    //   } catch (e) {
                    //     print("review error $e");
                    //   }
                    // });

                    if (Platform.isAndroid || Platform.isIOS) {
                      final appId = Platform.isAndroid ? 'com.examtest.formula.app' : 'YOUR_IOS_APP_ID';
                      final url = Uri.parse(
                        Platform.isAndroid
                            ? "market://details?id=$appId"
                            : "https://apps.apple.com/app/id$appId",
                      );
                      launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review not available'),
                      ),
                    );
                  }
                }).catchError((e){
                  print("Error : $e");
                });
              },
              leading: const Icon(
                Icons.star_border_outlined,
              ),
              title: const Text(
                'Rate Us',
              ),
            ),
            ListTile(
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.examtest.formula.app');
              },
              leading: const Icon(
                Icons.share,
              ),
              title: const Text(
                'Share',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
