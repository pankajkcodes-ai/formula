import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Feedback extends StatefulWidget {
  const Feedback({super.key});

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
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
              ElevatedButton(
                onPressed: () async {
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
                child: const Text('Send'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
