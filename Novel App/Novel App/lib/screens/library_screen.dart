import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/ads/bannerAd.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/disapproved_novels.dart';
import 'package:semster_project/components/horizontallist.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/novel_detail_screen.dart';
import 'package:semster_project/screens/novel_screen.dart';
import 'package:semster_project/screens/pdf_read.dart';
import 'package:semster_project/sevice/database.dart';

class Library_Screen extends StatefulWidget {
  const Library_Screen({super.key});

  @override
  State<Library_Screen> createState() => _Library_ScreenState();
}

class _Library_ScreenState extends State<Library_Screen> {
  List<Novel>? novelList;
  List<Novel>? novelListDis;

  bool isLoading = true;
  DatabaseReference? databaseNovelRef;
  List<Novel>? likedNovels;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseMethods()
        .fetchLikedNovels()
        .then((value) => setState(() {
              likedNovels = value;
            }))
        .then((value) => null);
    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        isLoading = false;
      });
    });

    DatabaseMethods().fetchNewNovels().then((value) => setState(() {
          novelList = value;
        }));
    fetchDisNovels().then((value) => setState(() {
          novelListDis = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const appbarTitle(
          title: "Library",
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HorizontalList(
                      novelList: novelList!.reversed.toList(),
                      title: "Added Recently ",
                      subnovelList: novelList!.reversed.toList(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    HorizontalList(
                      novelList: likedNovels!.reversed.toList(),
                      subnovelList: likedNovels!.reversed.toList(),
                      title: "Liked Novels",
                    ),
                    !ActiveUser.active!.isSuperUser
                        ? SizedBox()
                        : HorizontalList(
                            isSpecialOption: true,
                            novelList: novelListDis!.reversed.toList(),
                            subnovelList:
                                subNovelList(novelListDis).reversed.toList(),
                            title: "Disapproved Novels",
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    const BannerExample(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List<Novel> subNovelList(List<Novel>? novelList) {
    int val = 5;
    return novelList!
        .sublist(0, novelList.length > val ? val : novelList.length);
  }
}
