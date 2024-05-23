import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';

class AvatarImage extends StatelessWidget {
  AvatarImage({super.key, required this.img});
  String img;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            img,
          ),
        ));
  }
}
