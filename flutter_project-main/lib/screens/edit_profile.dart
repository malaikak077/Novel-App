import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/screens/avatar.dart';
import 'package:semster_project/screens/bottomnavi.dart';

import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/library_screen.dart';

import 'package:semster_project/sevice/database.dart';

import 'edit-avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static String id = "EditProfileScreen";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Usermodel? fetchUser;
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref("user");
  String username = "";

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
        centerTitle: true,
        title: appbarTitle(title: 'Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      AvatarImage(
                        img: ActiveUser.tempImg ?? ActiveUser.active!.image,
                      ),
                      Positioned(
                          bottom: -5,
                          right: -27,
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAvatar_Screen(
                                          user: ActiveUser.active)));
                            },
                            elevation: 2.0,
                            fillColor: kTextColor,
                            child: Icon(
                              Icons.edit,
                              color: kBackgroundColor,
                            ),
                            padding: EdgeInsets.all(1.0),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
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
                                initialValue: ActiveUser.active!.username,
                                onChanged: (val) => username = val,

                                keyboardType: TextInputType.multiline,

                                decoration: kTextInputDecorationWriter(
                                    "User Name", "Enter Username"),
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
                                    await DatabaseMethods()
                                        .fetchAllUsers(username.toString())
                                        .then((value) => setState(() {
                                              fetchUser = value;
                                            }));

                                    if ((username.toString() ==
                                                ActiveUser.active!.username ||
                                            username.toString() == "") &&
                                        (ActiveUser.active!.image !=
                                                ActiveUser.tempImg &&
                                            ActiveUser.tempImg != null)) {
                                      await databaseRef
                                          .child(ActiveUser.active!.email
                                              .replaceAll(".com", "_com"))
                                          .update(
                                              {"image": ActiveUser.tempImg});
                                      ActiveUser.active!.image =
                                          ActiveUser.tempImg!;
                                      ActiveUser.tempImg = null;
                                      // If the form is valid, display a snackbar. In the real world,
                                    } else if (username.toString() ==
                                        fetchUser!.username) {
                                      throw Exception();
                                    } else {
                                      print(username.toString());
                                      await databaseRef
                                          .child(ActiveUser.active!.email
                                              .replaceAll(".com", "_com"))
                                          .update({
                                        "username": username.toString(),
                                        "image": ActiveUser.active!.image
                                      });
                                      ActiveUser.active!.image =
                                          ActiveUser.tempImg ??
                                              ActiveUser.active!.image;
                                      ActiveUser.tempImg = null;
                                      ActiveUser.active!.username =
                                          username.toString();
                                    }
                                    // ignore: use_build_context_synchronously
                                    showAlert(
                                            context: context,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottomNavigation_Screen()));
                                            },
                                            title: 'Congratulation ',
                                            desc: 'Profile Updated',
                                            alertType: AlertType.success)
                                        .show();
                                  }
                                } catch (e) {
                                  print(e.toString());
                                  // ignore: use_build_context_synchronously
                                  showAlert(
                                          context: context,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          title: 'Username Already Exits',
                                          desc: 'Please use different Username',
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
