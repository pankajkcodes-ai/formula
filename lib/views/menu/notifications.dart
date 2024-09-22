import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(11)),
              child: Text("This is test notification"),
            );
          }),
    );
  }
}