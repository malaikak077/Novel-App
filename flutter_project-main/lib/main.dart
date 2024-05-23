import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:semster_project/ads/app_open_ad_manager.dart';
import 'package:semster_project/ads/applifecycle.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/firebase_options.dart';
import 'package:semster_project/screens/avatar.dart';
import 'package:semster_project/screens/edit_profile.dart';
import 'package:semster_project/screens/novel_screen.dart';
import 'package:semster_project/screens/pdf_read.dart';
import 'package:semster_project/screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: kTextColor,
              selectedItemColor: kBackgroundColor.withOpacity(1),
              unselectedItemColor: kBackgroundColor.withOpacity(0.5)),
          colorScheme: ColorScheme.fromSeed(
              seedColor: kTextColor,
              primary: kTextColor,
              secondary: kTextColor,
              onBackground: kTextColor,
              onPrimaryContainer: kTextColor,
              inversePrimary: kBackgroundColor,
              background: kTextColor,
              secondaryContainer: kTextColor),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              iconTheme: IconThemeData(color: kBackgroundColor),
              titleTextStyle: TextStyle(color: kBackgroundColor),
              color: kTextColor),
          hintColor: kBackgroundColor,
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Ubuntu',
            ),
          )),
      initialRoute: SplashPage.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        SplashPage.id: (context) => const SplashPage(),
        NewScreen.id: (context) => NewScreen(),
        EditProfileScreen.id: (context) => EditProfileScreen()
      },
    );
  }
}
