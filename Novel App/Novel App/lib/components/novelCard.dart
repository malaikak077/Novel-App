import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/novel_detail_screen.dart';
import 'package:semster_project/screens/pdf_read.dart';
import 'package:semster_project/sevice/database.dart';

class NovelCard extends StatefulWidget {
  NovelCard({
    super.key,
    required this.novel,
    required this.genre,
    this.onPress,
  });
  final Novel novel;
  final String genre;
  Function? onPress;
  @override
  State<NovelCard> createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isClicked = false;
  bool? isApproved;
  int counter = 0;
  DatabaseReference? databaseUserRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      databaseUserRef = ActiveUser.isGoogle
          ? FirebaseDatabase.instance
              .ref("users/${ActiveUser.active!.id}/liked_novel")
          : FirebaseDatabase.instance.ref(
              "user/${ActiveUser.active!.email.replaceAll(".com", "_com")}/liked_novel");

      counter = widget.novel.likes;
      isApproved = widget.novel.approved;
    });

    DatabaseMethods()
        .isLikedNovel(widget.novel.title, databaseUserRef)
        .then((value) => setState(() => isClicked = value));
  }

  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance
        .ref("NOVEL")
        .child("novels/${widget.genre}/${widget.novel.title}");

    return GestureDetector(
      key: _scaffoldKey,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NovelDetailScreen(novel: widget.novel, genre: widget.genre))),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(1))),
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.novel.image_url,
                    width: 100,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.novel.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: new Text(
                              widget.novel.description
                                      .toString()
                                      .substring(0, 120) +
                                  "....",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: const Color.fromARGB(255, 82, 80, 80),
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ActiveUser.active!.isSuperUser
                                  ? Row(
                                      children: [
                                        IconButton(
                                            onPressed: isApproved!
                                                ? () {}
                                                : () async {
                                                    widget.onPress;
                                                    await databaseRef!.update(
                                                        {"_approved": "true"});
                                                    setState(() {
                                                      isApproved = true;
                                                    });
                                                  },
                                            icon: Icon(
                                              Icons.check,
                                              color: isApproved!
                                                  ? Colors.grey
                                                  : Colors.green,
                                              size: 27,
                                            )),
                                      ],
                                    )
                                  : SizedBox(),
                              ActiveUser.active!.isSuperUser
                                  ? Row(
                                      children: [
                                        IconButton(
                                            onPressed: isApproved!
                                                ? () async {
                                                    await databaseRef!.update(
                                                        {"_approved": "false"});
                                                    setState(() {
                                                      isApproved = false;
                                                    });
                                                  }
                                                : () {},
                                            icon: Icon(
                                              Icons.close,
                                              color: isApproved!
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 27,
                                            )),
                                      ],
                                    )
                                  : SizedBox(),
                              ActiveUser.active!.isSuperUser
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isClicked = !isClicked;
                                                if (isClicked != false) {
                                                  counter = counter + 1;
                                                  databaseRef!.update({
                                                    "_likes": counter.toString()
                                                  });
                                                  databaseUserRef!
                                                      .child(
                                                          widget.novel.title)!
                                                      .set({
                                                    "novel_title":
                                                        widget.novel.title,
                                                    "genre": widget.genre
                                                  });
                                                } else {
                                                  counter = counter - 1;
                                                  databaseRef!.update({
                                                    "_likes": counter.toString()
                                                  });
                                                  databaseUserRef!
                                                      .child(widget.novel.title)
                                                      .remove();
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              isClicked == true
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            )),
                                        Text(counter > 1000
                                            ? " ${(counter / 1000).toStringAsFixed(2)} k"
                                            : counter.toString())
                                      ],
                                    ),
                            ])
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
