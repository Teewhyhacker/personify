class UserModel {
  final String? uid;
  final String? email;
  final String? displayName;

  UserModel({this.uid, this.email, this.displayName});
}
class UserDataModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? userName;
  final int? age;
  final String? state;
  final String? country;
  final String? gender;
  UserDataModel(
      {this.uid,
      this.email,
      this.displayName,
      this.userName,
      this.age,
      this.state,
      this.country,
      this.gender});
}