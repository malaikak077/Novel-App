import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/ads/nativeAd.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/novelCard.dart';

import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/bottomnavi.dart';
import 'package:semster_project/screens/library_screen.dart';

// ignore: must_be_immutable
class Disapproved_Screen extends StatefulWidget {
  Disapproved_Screen({super.key, required this.disNovelList});

  List<Novel>? disNovelList;
  @override
  State<Disapproved_Screen> createState() => _Disapproved_ScreenState();
}

class _Disapproved_ScreenState extends State<Disapproved_Screen> {
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL").child("novels");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                        builder: (context) => (BottomNavigation_Screen())));
              },
            );
          },
        ),
        centerTitle: true,
        title: appbarTitle(
          title: "Dissaproved Novels",
        ),
      ),
      body:
          // Add a flexible widget to allow the ListView to take remaining space
          Container(margin: EdgeInsets.only(top: 10), child: novelList()),
    );
  }

  Widget novelList() {
    return ListView.builder(
      itemCount: widget.disNovelList == null ? 0 : widget.disNovelList!.length,
      itemBuilder: (context, index) {
        Novel novel = widget.disNovelList![index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NovelCard(genre: novel.genre, novel: novel),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            (index + 1) % 3 == 0 ? NativeExample() : SizedBox(),
          ],
        );
      },
    );
  }
}
