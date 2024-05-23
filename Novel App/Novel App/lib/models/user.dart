class Usermodel {
  String email;
  String password;
  String username;
  String image;
  String id;
  bool isSuperUser;
  Usermodel(
      {required this.email,
      required this.password,
      required this.username,
      this.image = "",
      this.id = "",
      this.isSuperUser = false});
}
