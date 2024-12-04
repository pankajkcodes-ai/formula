import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 11,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: const Color(0xff006973).withOpacity(0.9),
            highlightColor: Colors.grey[200]!,
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: Colors.red),
            ),
          );
        });
  }
}
