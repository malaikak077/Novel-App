import 'package:flutter/material.dart';
import 'package:semster_project/components/logoimg.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/bottomnavi.dart';
import 'package:semster_project/screens/library_screen.dart';
import 'package:semster_project/sevice/database.dart';
import '../components/components.dart';
import '../constants.dart';

import 'package:loading_overlay/loading_overlay.dart';
import '../screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late Usermodel user;
  late String _email;
  late String _password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return false;
      },
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 334,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ScreenTitle(title: 'Login'),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomFormField(
                                textFormField: TextFormField(
                                  style: TextStyle(color: kTTextColor),
                                  validator: (val) => EmailValidator(val),
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  decoration: kTextInputDecorationWriter(
                                      "Email", "Enter Email"),
                                ),
                              ),
                              CustomFormField(
                                textFormField: TextFormField(
                                  style: TextStyle(color: kTTextColor),
                                  validator: (val) => TextValidator(val),
                                  obscureText: true,
                                  onChanged: (value) {
                                    _password = value;
                                  },
                                  decoration: kTextInputDecorationWriter(
                                      "Password", "Enter Password"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomBottomScreen(
                          textButton: 'Login',
                          heroTag: 'login_btn',
                          question: 'Forgot password?',
                          buttonPressed: () async {
                            try {
                              if (_formKey.currentState!.validate()) {
                                await DatabaseMethods()
                                    .fetchUserOnce(email: _email)
                                    .then((value) =>
                                        setState(() => user = value));

                                print(user.image);
                                if (user.email == _email &&
                                    user.password == _password) {
                                  ActiveUser.isGoogle = false;
                                  ActiveUser.active = user;
                                  ActiveUser.active!.isSuperUser =
                                      user.isSuperUser;
                                  setState(() {
                                    _saving = false;
                                  });

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation_Screen()));
                                } else {
                                  throw Exception();
                                }
                              }
                            } catch (e) {
                              signUpAlert(
                                context: context,
                                onPressed: () {
                                  setState(() {
                                    _saving = false;
                                    Navigator.pop(context);
                                  });
                                },
                                title: 'WRONG PASSWORD OR EMAIL',
                                desc:
                                    'Confirm your email and password and try again',
                                btnText: 'Try Now',
                              ).show();
                            }
                          },
                          questionPressed: () {
                            signUpAlert(
                              onPressed: () async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: _email);
                              },
                              title: 'RESET YOUR PASSWORD',
                              desc:
                                  'Click on the button to reset your password',
                              btnText: 'Reset Now',
                              context: context,
                            ).show();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
