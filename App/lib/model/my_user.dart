import 'package:flutter/material.dart';

class MyUser extends ChangeNotifier {
  final String uid;
  final String? email;
  final String? fullName;
  String? mobile;
  final String? profile;
  String? token;

  void setToken(String tkn) {
    this.token = tkn;

    notifyListeners();
  }

  MyUser(
      {required this.email,
      required this.token,
      required this.fullName,
      required this.mobile,
      required this.profile,
      required this.uid});
}
