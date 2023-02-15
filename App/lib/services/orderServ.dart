import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/model/orderInfo.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../constants/error_handling.dart';
import '../constants/globvar.dart';

class OrderServ {
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    String Bearer = 'Bearer ' +
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    print(Bearer);
    try {
      print('hello');
      http.Response res = await http.get(
          Uri.parse('http://10.0.2.2:8080/food/order?status=responsePending'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': Bearer
          });
      var obj = jsonDecode(res.body);
      print(obj[0].runtimeType);
      print(obj);
      print(res.body);
      // print(res.body.runtimeType);
      print(obj.runtimeType);
      print(res.body.length);
      print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          print(OrderList);
          print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    print('xxx');
    return OrderList;
  }
}
