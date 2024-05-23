import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/components/disapproved_novels.dart';
import 'package:semster_project/components/novelCard2.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/novel_detail_screen.dart';
import 'package:semster_project/screens/viewall.dart';

class HorizontalList extends StatefulWidget {
  HorizontalList(
      {super.key,
      required this.novelList,
      this.title = "Recents",
      required this.subnovelList,
      this.isSpecialOption = false});
  bool isSpecialOption;
  List<Novel>? novelList;
  List<Novel>? subnovelList;
  String title;
  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.novelList!.length == 0) {
      return SizedBox();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20,
                    color: kTextColor,
                    fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                  onTap: () => PushNextScreen(
                      context: context,
                      widget: widget.isSpecialOption
                          ? Disapproved_Screen(
                              disNovelList: widget.novelList,
                            )
                          : ViewAll_Screen(
                              novelLists: widget.novelList,
                            )),
                  child: Row(
                    children: [
                      Text(
                        "View all",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 15,
                            color: kTextColor.withOpacity(0.8),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      )
                    ],
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 190.0,
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.subnovelList == null
                      ? 0
                      : widget.subnovelList!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                        onTap: () => PushNextScreen(
                            context: context,
                            widget: NovelDetailScreen(
                              novel: widget.subnovelList![index],
                              genre: widget.subnovelList![index].genre,
                            )),
                        child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            width: 110,
                            child: NovelCard2(
                              novel: widget.subnovelList![index],
                            )));
                  }),
            ),
          ),
        ],
      );
    }
  }
}
