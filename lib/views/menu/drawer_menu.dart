import 'package:flutter/material.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';

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
                  if (isAvailable) {
                    inAppReview.requestReview();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review not available'),
                      ),
                    );
                  }
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
