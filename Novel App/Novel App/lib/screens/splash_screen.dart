import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/logoimg.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/login_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static String id = 'splash_screen';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          LogoImage(),
          ScreenTitle(title: 'Novels Gem'),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(
            color: kTextColor,
          ),
        ]),
      ),
    );
  }
}
