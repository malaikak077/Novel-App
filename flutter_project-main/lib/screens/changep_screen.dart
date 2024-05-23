import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/screens/bottomnavi.dart';

import 'package:semster_project/screens/me_screen.dart';

class ChangePassworrdScreen extends StatefulWidget {
  const ChangePassworrdScreen({super.key});
  static String id = "ChangePassworrdScreen";

  @override
  State<ChangePassworrdScreen> createState() => _ChangePassworrdScreenState();
}

class _ChangePassworrdScreenState extends State<ChangePassworrdScreen> {
  Usermodel? fetchUser;
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref(
      "user/${ActiveUser.active!.email.toString().replaceAll(".com", "_com")}");
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ActiveUser.tempImg = null;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation_Screen(
                              selectedIndex: 2,
                            )));
              },
            );
          },
        ),
        title: ScreenTitle(title: 'Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarImage(
                  img: ActiveUser.tempImg ?? ActiveUser.active!.image,
                ),
                Container(
                  width: 360,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomFormField(
                              textFormField: TextFormField(
                                obscureText: true,
                                onChanged: (val) => currentPassword = val,

                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                decoration: kTextInputDecorationWriter(
                                    "Current Password",
                                    "Enter Current Password",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                              textFormField: TextFormField(
                                obscureText: true,
                                onChanged: (val) => newPassword = val,

                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                decoration: kTextInputDecorationWriter(
                                    "New Password", "Enter Password",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                              textFormField: TextFormField(
                                obscureText: true,
                                onChanged: (val) => confirmPassword = val,

                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                decoration: kTextInputDecorationWriter(
                                    "Confirm Password", "Enter Password",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              width: 400,
                              buttonText: "Submit",
                              onPressed: () async {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    if (currentPassword !=
                                        ActiveUser.active!.password) {
                                      throw Exception();
                                    }
                                    if (newPassword == confirmPassword) {
                                      databaseRef.update(
                                          {"password": confirmPassword});
                                      ActiveUser.active!.password =
                                          confirmPassword;
                                      showAlert(
                                              context: context,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Me_Screen()));
                                              },
                                              title: 'Congratulation ',
                                              desc: 'Password Updated',
                                              alertType: AlertType.success)
                                          .show();
                                    } else {
                                      showAlert(
                                              context: context,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              title: 'Passwords Doesn\'t Match',
                                              desc:
                                                  'Please Enter Correct Passwords',
                                              alertType: AlertType.error)
                                          .show();
                                    }

                                    // ignore: use_build_context_synchronously
                                  }
                                } catch (e) {
                                  print(e.toString());
                                  // ignore: use_build_context_synchronously
                                  showAlert(
                                          context: context,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          title: 'Current Password Miss Match',
                                          desc: '',
                                          alertType: AlertType.error)
                                      .show();
                                } // Validate returns true if the form is valid, or false otherwise.
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
