import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
          "assets/images/no-data.png",
          height: 100,
        ));
  }
}
