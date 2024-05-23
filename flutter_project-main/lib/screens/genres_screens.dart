import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:semster_project/constants.dart';
import 'package:semster_project/models/genre.dart';
import 'package:semster_project/screens/novel_screen.dart';
import '../components/components.dart';
import '../sevice/database.dart';

class Genres_Screen extends StatefulWidget {
  const Genres_Screen({super.key});

  @override
  State<Genres_Screen> createState() => _Genres_ScreenState();
}

class _Genres_ScreenState extends State<Genres_Screen> {
  List<Genre>? genreList;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseMethods()
        .fetchGenre()
        .then((value) => setState(() => genreList = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const appbarTitle(
          title: "Genre",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: genreList == null ? 0 : genreList!.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: () => PushNextScreen(
                      context: context,
                      widget: NewScreen(
                        genre: genreList![index].genre,
                      )),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // S
                    child: SizedBox(
                      height: 200,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            // Add ClipRRect for border radius
                            borderRadius: BorderRadius.circular(
                                10.0), // Set your desired border radius
                            child: Image.network(
                              genreList![index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            // Clip it cleanly.
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                                alignment: Alignment.center,
                                child: Text(
                                  genreList![index].genre,
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: kBackgroundColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
