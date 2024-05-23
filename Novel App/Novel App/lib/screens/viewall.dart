import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:semster_project/components/novelCard2.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/genre.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/bottomnavi.dart';
import 'package:semster_project/screens/library_screen.dart';
import 'package:semster_project/screens/novel_detail_screen.dart';
import 'package:semster_project/screens/novel_screen.dart';
import '../components/components.dart';
import '../sevice/database.dart';

class ViewAll_Screen extends StatefulWidget {
  ViewAll_Screen({super.key, required this.novelLists});
  List<Novel>? novelLists;
  @override
  State<ViewAll_Screen> createState() => _ViewAll_ScreenState();
}

class _ViewAll_ScreenState extends State<ViewAll_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            );
          },
        ),
        title: const appbarTitle(
          title: "View All",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 140,
                childAspectRatio: 0.62,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount:
                widget.novelLists == null ? 0 : widget.novelLists!.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: () => PushNextScreen(
                      context: context,
                      widget: NovelDetailScreen(
                        novel: widget.novelLists![index],
                        genre: widget.novelLists![index].genre,
                      )),
                  child: NovelCard2(
                    novel: widget.novelLists![index],
                  ));
            }),
      ),
    );
  }
}
