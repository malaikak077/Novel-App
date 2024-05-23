import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/screens/bottomnavi.dart';

import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/library_screen.dart';

import 'package:semster_project/sevice/database.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL");
  String _title = "";
  String _write_name = "";
  String _novel_url = "";
  String _image_url = "";
  String _description = "";
  String dropdownValue = "Horror";
  List<String> list = <String>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseMethods().fetchGenre().then((value) => value.forEach((element) {
          setState(() {
            list.add(element.genre);
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbarTitle(title: 'Writer Form'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                onChanged: (val) => _title = val,

                                keyboardType: TextInputType.multiline,

                                decoration: kTextInputDecorationWriter(
                                    "Title", "Enter Novel Title"),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            CustomFormField(
                              textFormField: TextFormField(
                                onChanged: (val) => _write_name = val,

                                keyboardType: TextInputType.multiline,

                                decoration: kTextInputDecorationWriter(
                                    "Writer Name", "Enter Novel\'s Write Name"),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            CustomFormField(
                              textFormField: TextFormField(
                                onChanged: (val) => _novel_url = val,

                                keyboardType: TextInputType.multiline,

                                decoration: kTextInputDecorationWriter(
                                    "Novel URL", "Enter Novel URL"),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            CustomFormField(
                              textFormField: TextFormField(
                                onChanged: (val) => _image_url = val,

                                keyboardType: TextInputType.multiline,

                                decoration: kTextInputDecorationWriter(
                                    "Image URL", "Enter Image URL"),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            DropdownMenu<String>(
                              initialSelection: dropdownValue,
                              width: MediaQuery.of(context).size.width - 40,
                              inputDecorationTheme: InputDecorationTheme(
                                errorStyle:
                                    TextStyle(fontSize: 15, color: kErrorColor),
                                labelStyle: TextStyle(
                                  color: kTextColor,
                                  fontSize: 22,
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: kBackgroundColor.withOpacity(0.7)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: kTextColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: kErrorColor),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                              menuStyle: MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(kTextColor),
                              ),
                              label: Text("Genre"),
                              onSelected: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownMenuEntries: list
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                );
                              }).toList(),
                            ),
                            CustomFormField(
                              textFormField: TextFormField(
                                onChanged: (val) => _description = val,
                                maxLength: 400,
                                maxLines: 8,
                                keyboardType: TextInputType.multiline,

                                decoration: kTextInputDecorationWriter(
                                    "Description", "Enter Novel Descripton",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                cursorColor: kTextColor,
                                // The validator receives the text that the user has entered.
                                validator: (value) => TextValidator(value),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CustomButton(
                              width: 400,
                              buttonText: "Submit",
                              onPressed: () {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    String id = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .abs()
                                        .toString()
                                        .substring(5);

                                    databaseRef
                                        .child('novels')
                                        .child(dropdownValue)
                                        .child(_title.toString())
                                        .set({
                                      "_approved": "false",
                                      "_likes": 0.toString(),
                                      "_title": _title.toString(),
                                      "_write_name": _write_name.toString(),
                                      "_novel_url": _novel_url.toString(),
                                      "_image_url": _image_url.toString(),
                                      "_description": _description.toString(),
                                      "id": int.parse(id),
                                      "createdAt": DateTime.now().toString()
                                    });
                                    // If the form is valid, display a snackbar. In the real world,
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
                                            desc: 'Your Novel is Submitted',
                                            alertType: AlertType.success)
                                        .show();
                                  }
                                } catch (e) {
                                  print(e);
                                } // Validate returns true if the form is valid, or false otherwise.
                              },
                            ),
                            SizedBox(
                              height: 40,
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
