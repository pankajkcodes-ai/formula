import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../res/resources.dart';

class MyFeedback extends StatefulWidget {
  const MyFeedback({super.key});

  @override
  State<MyFeedback> createState() => _MyFeedbackState();
}

class _MyFeedbackState extends State<MyFeedback> {
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiaryFixed,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Text(
            "Feedback",
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(21),
        children: [
          // Title
          const Text(
            'Give feedback',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Subtitle
          const Text(
            'What do you think of to improve this app?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),

          // Text Field
          TextField(
            controller: _feedbackController,
            decoration: const InputDecoration(
              labelText: "Type...",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async{
                  if (_feedbackController.text.trim() != "") {
                    final Uri params = Uri(
                      scheme: 'mailto',
                      path: 'upsoftech.info@gmail.com',
                      query:
                      'subject=Formula App Feedback&body=${_feedbackController.text.trim()}', //add subject and body here
                    );

                    var url = params.toString();
                    if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                  _feedbackController.clear();
                  } else {
                  throw 'Could not launch $url';
                  }
                  } else {
                  Fluttertoast.showToast(msg: "Please provide feedback");
                  }
                },
                child: Container(
                  height: Resources.dimens.height(context) * 0.04,
                  width: Resources.dimens.width(context) * 0.3,
                  decoration:
                  Resources.styles.kBoxBorderDecorationR3(context),
                  child:  Center(child: Text('Send',
                      style: Resources.styles.kTextStyle14B5(Theme.of(context).colorScheme.tertiaryFixed)
                  )),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: Resources.dimens.height(context) * 0.04,
                  width: Resources.dimens.width(context) * 0.3,
                  decoration:
                  Resources.styles.kBoxBorderDecorationR3(context),
                  child:  Center(child: Text('Cancel',
                      style: Resources.styles.kTextStyle14B5(Theme.of(context).colorScheme.tertiaryFixed)
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
