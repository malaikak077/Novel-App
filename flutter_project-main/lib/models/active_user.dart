import 'package:semster_project/models/novel.dart';
import 'package:semster_project/models/user.dart';

class ActiveUser {
  static bool isGoogle = false;
  static Usermodel? active;
  static String? tempImg;

  static List<Novel>? likedNovels;
}
