import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';

class LogoImage extends StatelessWidget {
  LogoImage({super.key});
  String img = "assets/images/icons/logo.png";
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: kBackgroundColor,
        radius: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            img,
            fit: BoxFit.contain,
          ),
        ));
  }
}
