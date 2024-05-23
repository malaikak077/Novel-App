import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/user.dart';
import 'package:semster_project/screens/edit_profile.dart';
import 'package:semster_project/screens/genres_screens.dart';
import 'package:semster_project/screens/home_screen.dart';
import 'package:semster_project/screens/login_screen.dart';
import 'package:semster_project/screens/writer_screen.dart';
import 'package:semster_project/sevice/database.dart';
import '../components/components.dart';

class EditAvatar_Screen extends StatefulWidget {
  const EditAvatar_Screen({super.key, required this.user});
  final Usermodel? user;
  static String id = 'EditAvatar_Screen';

  @override
  State<EditAvatar_Screen> createState() => _EditAvatar_ScreenState();
}

class _EditAvatar_ScreenState extends State<EditAvatar_Screen> {
  List<AvatarImage> avatarList = List.empty();
  Image? image;
  String imagePath = ActiveUser.active!.image;
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
        centerTitle: true,
        title: appbarTitle(title: "Edit Profile Picture"),
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
                backgroundColor: kBackgroundColor,
                child: image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.network(
                          ActiveUser.active!.image,
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(120), child: image),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(5),
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
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                buttonText: 'Select',
                onPressed: () {
                  ActiveUser.tempImg = imagePath!;

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
