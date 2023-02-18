import 'package:flutter/material.dart';
import 'package:hotshot/model/my_user.dart';

final textInputDecoration = InputDecoration(
    //fillColor: Colors.white10,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.transparent)));

final drawerButtonStyle = ButtonStyle(
  fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.maxFinite)),
  alignment: Alignment.centerLeft,
);

MyUser dummyUser = MyUser(
    email: 'abc@email.com',
    token: 'token',
    fullName: 'fullname',
    mobile: '1234567890',
    profile: '',
    uid: '');

const MONGO_URL = 'http://192.168.1.108:8080';
