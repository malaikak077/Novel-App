import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:semster_project/components/avatarImg.dart';
import 'package:semster_project/models/active_user.dart';
import 'package:semster_project/models/genre.dart';
import 'package:semster_project/models/novel.dart';
import 'package:semster_project/models/user.dart';

class DatabaseMethods {
  Future addUser(String uid, Map<String, dynamic> userInfoMap) {
    return FirebaseDatabase.instance.ref("users").child(uid).set(userInfoMap);
  }

  Future<Usermodel> fetchGoogleUser(String uid) async {
    final ref = FirebaseDatabase.instance.ref("users/${uid}");
    DataSnapshot dataSnapshot = await ref.get();
    if (dataSnapshot.exists) {
      return Usermodel(
          username: dataSnapshot.child("username").value.toString(),
          email: dataSnapshot.child("email").value.toString(),
          password: dataSnapshot.child("password").value.toString(),
          image: dataSnapshot.child("image").value.toString(),
          isSuperUser:
              bool.parse(dataSnapshot.child("superUser").value.toString()));
    }
    return Usermodel(
      username: "",
      email: "",
      password: "",
      image: "",
    );
  }

  Future<List<Genre>> fetchGenre() async {
    List<Genre> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        childList.add(Genre(
            genre: element.child("Genre").value.toString(),
            image: element.child("Image").value.toString()));
      });
    }

    return childList;
  }

  Future<List<String>> fetchGenreString() async {
    List<String> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        childList.add(element.child("Genre").value.toString());
      });
    }

    return childList;
  }

  Future<List<AvatarImage>> fetchAvatar() async {
    List<AvatarImage> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("Avatar");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        childList.add(AvatarImage(img: element.child("img").value.toString()));
      });
    }

    return childList;
  }

  fetchUsers({email, username}) async {
    Usermodel childList = Usermodel(email: "", password: "", username: "");
    final databaseRef = FirebaseDatabase.instance.ref("user");

    DataSnapshot dataSnapshot = await databaseRef
        .child(email.toString().replaceAll(".com", "_com"))
        .get();

    if (dataSnapshot.exists) {
      childList = Usermodel(
          username: dataSnapshot.child("username").value.toString(),
          email: dataSnapshot.child("email").value.toString(),
          password: dataSnapshot.child("password").value.toString(),
          image: dataSnapshot.child("image").value.toString());
    } else {
      await fetchAllUsers(username).then((value) {
        childList = value;
        print(childList.username);
      });
    }

    return childList;
  }

  Future<Usermodel> fetchAllUsers(username) async {
    Usermodel childList = Usermodel(email: "", password: "", username: "");
    final databaseRef = FirebaseDatabase.instance.ref("user/");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        if (element.child("username").value.toString() == username) {
          childList = Usermodel(
              username: element.child("username").value.toString(),
              email: element.child("email").value.toString(),
              password: element.child("password").value.toString(),
              image: element.child("image").value.toString());
        }
      });
    }

    return childList;
  }

  fetchUserOnce({email}) async {
    Usermodel childList = Usermodel(email: "", password: "", username: "");
    final databaseRef = FirebaseDatabase.instance.ref("user");

    DataSnapshot dataSnapshot = await databaseRef
        .child(email.toString().replaceAll(".com", "_com"))
        .get();

    if (dataSnapshot.exists) {
      childList = Usermodel(
          username: dataSnapshot.child("username").value.toString(),
          email: dataSnapshot.child("email").value.toString(),
          password: dataSnapshot.child("password").value.toString(),
          image: dataSnapshot.child("image").value.toString(),
          isSuperUser: dataSnapshot.hasChild("superUser")
              ? bool.parse(dataSnapshot.child("superUser").value.toString())
              : false);
    }
    return childList;
  }

  Future<List<Novel>> fetchNewNovels() async {
    List<Novel> childList = [];
    final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

    DataSnapshot dataSnapshot = await databaseRef.get();

    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        element.children.forEach((element1) {
          try {
            DateTime fileCreationDateTime =
                DateTime.parse(element1.child("createdAt").value.toString());
            if (DateTime.now().difference(fileCreationDateTime).inDays <= 50 &&
                bool.parse(element1.child("_approved").value.toString())) {
              childList.add(Novel(
                  genre: element.child("Genre").value.toString(),
                  title: element1.child("_title").value.toString(),
                  writer: element1.child("_write_name").value.toString(),
                  novel_url: element1.child("_novel_url").value.toString(),
                  image_url: element1.child("_image_url").value.toString(),
                  likes: int.parse(element1.child("_likes").value.toString()),
                  description:
                      element1.child("_description").value.toString()));
            }
          } catch (e) {}
        });
      });
    }

    return childList;
  }

  Future<List<Novel>> fetchNovels(String title) async {
    List<Novel> childList = [];

    final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

    DataSnapshot dataSnapshot = await databaseRef.get();
    if (dataSnapshot != null) {
      dataSnapshot.children.forEach((element) {
        element.children.forEach((element1) {
          try {
            if (title == element1.child("_title").value.toString()) {}
            childList.add(Novel(
                genre: element.child("Genre").value.toString(),
                title: element1.child("_title").value.toString(),
                writer: element1.child("_write_name").value.toString(),
                novel_url: element1.child("_novel_url").value.toString(),
                image_url: element1.child("_image_url").value.toString(),
                likes: int.parse(element1.child("_likes").value.toString()),
                description: element1.child("_description").value.toString()));
          } catch (e) {}
        });
      });
    }

    return childList;
  }

  Future<bool> isLikedNovel(String novel_title, DatabaseReference? ref) async {
    DataSnapshot dataSnapshot = await ref!.get();
    if (dataSnapshot.hasChild(novel_title)) {
      return true;
    }
    return false;
  }

  Future<List<Novel>> fetchLikedNovels() async {
    List<Novel> likedNovelList = [];
    DatabaseReference databaseLNovelRef = ActiveUser.isGoogle
        ? FirebaseDatabase.instance
            .ref("users/${ActiveUser.active!.id}/liked_novel")
        : FirebaseDatabase.instance.ref(
            "user/${ActiveUser.active!.email.replaceAll(".com", "_com")}/liked_novel");
    DataSnapshot dataSnapshot = await databaseLNovelRef.get();

    dataSnapshot.children.forEach((element) {
      fetchANovel(
              genre: element.child("genre").value.toString(),
              title: element.child("novel_title").value.toString())
          .then((value) => value == null ? "" : likedNovelList.add(value!));
    });

    return likedNovelList;
  }
}

Future<Novel?> fetchANovel({String? genre, String? title}) async {
  Novel? novel;
  final ref = FirebaseDatabase.instance.ref("NOVEL/novels/$genre/$title");
  DataSnapshot dataSnapshot = await ref.get();
  String title1 = dataSnapshot.child("_title").value.toString();
  String approved = dataSnapshot.child("_approved").value.toString();
  String writer = dataSnapshot.child("_write_name").value.toString();
  String image_url = dataSnapshot.child("_image_url").value.toString();
  String description = dataSnapshot.child("_description").value.toString();
  String novel_url = dataSnapshot.child("_novel_url").value.toString();
  String likes = dataSnapshot.child("_likes").value.toString();
  if (bool.parse(approved)) {
    novel = Novel(
        likes: int.parse(likes),
        genre: genre!,
        title: title1,
        writer: writer,
        novel_url: novel_url,
        image_url: image_url,
        description: description);
  } else {
    novel = null;
  }

  return novel;
}

Future<List<Novel>> fetchNovels(String title) async {
  List<Novel> childList = [];

  final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

  DataSnapshot dataSnapshot = await databaseRef.get();
  if (dataSnapshot != null) {
    dataSnapshot.children.forEach((element) {
      element.children.forEach((element1) {
        try {
          if (title == element1.child("_title").value.toString()) {}
          childList.add(Novel(
              genre: element.child("Genre").value.toString(),
              title: element1.child("_title").value.toString(),
              writer: element1.child("_write_name").value.toString(),
              novel_url: element1.child("_novel_url").value.toString(),
              image_url: element1.child("_image_url").value.toString(),
              likes: int.parse(element1.child("_likes").value.toString()),
              description: element1.child("_description").value.toString()));
        } catch (e) {}
      });
    });
  }

  return childList;
}

Future<List<Novel>> fetchDisNovels() async {
  List<Novel> childList = [];
  final databaseRef = FirebaseDatabase.instance.ref("NOVEL/novels");

  DataSnapshot dataSnapshot = await databaseRef.get();

  if (dataSnapshot != null) {
    dataSnapshot.children.forEach((element) {
      element.children.forEach((element1) {
        try {
          if ("false" == element1.child("_approved").value.toString()) {
            childList.add(Novel(
                genre: element.child("Genre").value.toString(),
                title: element1.child("_title").value.toString(),
                writer: element1.child("_write_name").value.toString(),
                novel_url: element1.child("_novel_url").value.toString(),
                image_url: element1.child("_image_url").value.toString(),
                likes: int.parse(element1.child("_likes").value.toString()),
                description: element1.child("_description").value.toString()));
          }
        } catch (e) {}
      });
    });
  }

  return childList;
}
