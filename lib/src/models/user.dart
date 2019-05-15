import 'package:meta/meta.dart';
import 'package:milestone/src/models/school.dart';

@immutable
class User {
  final int id;
  final String name;
  final String mobile;
  final String uid;
  final String email;
  final String avatar;
  final String dob;
  final String gender;
  final String education;
  final School school;
  final String accountStatus;
  final int status;

  User({
    @required this.id,
    @required this.name,
    @required this.mobile,
    @required this.uid,
    @required this.email,
    @required this.avatar,
    @required this.dob,
    @required this.gender,
    @required this.education,
    @required this.school,
    @required this.accountStatus,
    @required this.status,
  });

  User copyWith(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      mobile: json["mobile"] ?? this.mobile,
      uid: json["uid"] ?? this.uid,
      email: json["email"] ?? this.email,
      avatar: json["avatar"] ?? this.avatar,
      dob: json["dob"] ?? this.dob,
      gender: json["gender"] ?? this.gender,
      education: json["education"] ?? this.education,
      school: json["school"] ?? this.school,
      accountStatus: json["account_status"] ?? this.accountStatus,
      status: json["status"] ?? this.status,
    );
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        uid = json["uid"],
        email = json["email"],
        avatar = json["avatar"],
        mobile = json["mobile"],
        dob = json["dob"],
        gender = json["gender"],
        education = json["education"],
        school = json["school"] is School
            ? json["school"]
            : School.fromJson(json["school"]),
        accountStatus = json["account_status"],
        status = json["status"];
}
