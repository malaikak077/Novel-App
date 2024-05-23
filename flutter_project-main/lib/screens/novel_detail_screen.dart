import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:semster_project/ads/bannerAd.dart';
import 'package:semster_project/ads/intertial.dart';
import 'package:semster_project/components/components.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/screens/pdf_read.dart';

// ignore: must_be_immutable
class NovelDetailScreen extends StatefulWidget {
  NovelDetailScreen({super.key, required this.novel, required this.genre});
  String genre;
  Novel novel;
  @override
  State<NovelDetailScreen> createState() => _NovelDetailScreenState();
}

class _NovelDetailScreenState extends State<NovelDetailScreen> {
  bool isReadMoreClicked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InterstitialExample _interstitialExample = InterstitialExample();
    return Stack(
      children: [
        Image.network(
          widget.novel.image_url,
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.grey.withOpacity(0.1),
          ),
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                  height: 210,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(widget.novel.image_url)),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            widget.novel.title,
                            style: titleStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 100,
                                child: Text(
                                  widget.novel.writer,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 106, 105, 105),
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "|",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 106, 105, 105),
                                  fontWeight: FontWeight.w100),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: kErrorColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(widget.novel.likes.toString(),
                                    style: likeStyle),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "|",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 106, 105, 105),
                                  fontWeight: FontWeight.w100),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kTextColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(5),
                                child: Text(widget.genre, style: detailStyle)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 310,
                                child: Text(
                                  widget.novel.description,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 106, 105, 105),
                                      fontSize: 15,
                                      wordSpacing: 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          buttonText: "Start Reading",
                          onPressed: () {
                            _interstitialExample.loadAd();

                            // ignore: use_build_context_synchronously
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PDF_Reader(
                                          novel_url: widget.novel.novel_url)));
                            });
                          },
                          width: 250,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BannerExample()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

TextStyle titleStyle = const TextStyle(
    color: Colors.black,
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold,
    fontSize: 25);

TextStyle detailStyle =
    const TextStyle(color: Color.fromARGB(255, 106, 105, 105), fontSize: 15);
TextStyle likeStyle =
    const TextStyle(color: Color.fromARGB(255, 180, 180, 180), fontSize: 15);

TextStyle paraStyle =
    const TextStyle(color: Color.fromARGB(255, 106, 105, 105), fontSize: 10);
