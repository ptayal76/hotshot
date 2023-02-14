import 'dart:convert';

// import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      print("alpha0");
      break;
    case 400:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['msg'])));
      print("alpha1");
      // showSnackBar(context, );
      break;
    case 500:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['error'])));
      print("alpha2");
      // showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
      print("alpha3");
      // showSnackBar(context, response.body);
  }
}
