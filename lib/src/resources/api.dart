import 'dart:async';

import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/user.dart';
import 'package:milestone/src/resources/client.dart';
import 'package:multipart_request/multipart_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Future getAuthUser() async {
    return sendRequest(Api.me);
  }

  Future authenticate(String mobile, String uid) async {
    return sendRequest(Api.authenticate, {
      "mobile": mobile,
      "uid": uid,
    });
  }

  Future getCategories() async {
    return sendRequest(Api.getCategories, {});
  }

  Future updateProfile(User user) async {
    return sendRequest(Api.updateProfile, {
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "dob": user.dob,
      "gender": user.gender,
      "school_id": user.school.id,
      "education": user.education,
    });
  }

  Future getSchools() async {
    return sendRequest(Api.getSchools);
  }

  Future uploadAvatar(file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("authToken");

    var request = MultipartRequest();

    request.setUrl(Api.uploadAvatar);
    request.addHeader("Authorization", "Bearer $token");
    request.addFile("image", file.path);

    return request.send();
  }
}

class Api {
  static String me = "$baseUrl/api/users/me";
  static String authenticate = "$baseUrl/api/device/authenticate";
  static String getSchools = "$baseUrl/api/home/schools";
  static String updateProfile = "$baseUrl/api/users/update";
  static String getCategories = "$baseUrl/api/categories/all";
  static String uploadAvatar = "$baseUrl/api/users/avatar/upload";
}
