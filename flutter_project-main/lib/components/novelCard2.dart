import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:semster_project/models/novel.dart';

class NovelCard2 extends StatelessWidget {
  NovelCard2({super.key, required this.novel});
  Novel novel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          // Add ClipRRect for border radius
          borderRadius:
              BorderRadius.circular(15.0), // Set your desired border radius
          child: Image.network(
            novel.image_url,
            fit: BoxFit.contain,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0), //
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              padding: EdgeInsets.all(1),
              color: Colors.black.withOpacity(0.2),
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
