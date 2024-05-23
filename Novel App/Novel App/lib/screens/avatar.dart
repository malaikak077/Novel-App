import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/genres_screens.dart';
import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/login_screen.dart';
import 'package:semster_project/screens/writer_screen.dart';
import 'package:semster_project/sevice/database.dart';
import '../components/components.dart';

class Avatar_Screen extends StatefulWidget {
  const Avatar_Screen({super.key, required this.user});
  final Usermodel user;
  static String id = 'avatar_screen';

  @override
  State<Avatar_Screen> createState() => _Avatar_ScreenState();
}

class _Avatar_ScreenState extends State<Avatar_Screen> {
  List<AvatarImage> avatarList = List.empty();
  Image? image;
  String? imagePath;
  final databaseRef = FirebaseDatabase.instance.ref("user");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseMethods().fetchAvatar().then((value) => setState(() {
          avatarList = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(title: "Select One Avatar"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 120,
                backgroundColor: Colors.black,
                child: image == null
                    ? Icon(
                        Icons.person,
                        size: 150,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(120), child: image),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          childAspectRatio: 1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 25),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: avatarList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            imagePath = avatarList[index].img;
                            image = Image.network(avatarList[index].img);
                          }),
                          child: avatarList[index],
                        );
                      })),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                buttonText: 'Submit',
                onPressed: () {
                  databaseRef
                      .child(widget.user.email.replaceAll(".com", "_com"))
                      .set({
                    "username": widget.user.username,
                    "email": widget.user.email,
                    "password": widget.user.password,
                    "image": imagePath,
                    "createdAt": DateTime.now().toString(),
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
