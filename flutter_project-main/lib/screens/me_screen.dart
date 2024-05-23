import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';

class Me_Screen extends StatefulWidget {
  const Me_Screen({super.key});

  @override
  State<Me_Screen> createState() => _Me_ScreenState();
}

class _Me_ScreenState extends State<Me_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: kListView(context)),
    );
  }
}
