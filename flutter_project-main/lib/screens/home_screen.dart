import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/ads/app_open_ad_manager.dart';
import 'package:semster_project/ads/applifecycle.dart';
import 'package:semster_project/components/logoimg.dart';
import 'package:semster_project/sevice/auth.dart';
import '../components/components.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseRef = FirebaseDatabase.instance
      .refFromURL("https://semster-project-17412-default-rtdb.firebaseio.com/");
  AppLifecycleReactor? _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    AppLifecycleReactor _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoImage(),
              const ScreenTitle(title: 'Novels Gem'),
              const SizedBox(
                height: 25,
              ),
              Hero(
                tag: 'login_btn',
                child: CustomButton(
                  buttonText: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Hero(
                tag: 'signup_btn',
                child: CustomButton(
                  buttonText: 'Sign Up',
                  isOutlined: true,
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.id);
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Sign up using',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      AuthMethods().signInWithGoogle(context);
                    },
                    icon: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/images/icons/google.png'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
