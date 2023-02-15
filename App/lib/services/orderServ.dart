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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2ViZGVmZGQyOTc0MzcyOTA4Y2E1YjciLCJpYXQiOjE2NzY0MDI0Mjl9.mStXAFdKq3EG7UhQxQLiXATfDzMyB9sWbGpfEoIekb8';
    print(Bearer);
    try {
      print('hello');
      http.Response res = await http
          .get(Uri.parse('http://10.0.2.2:8080/food/order'), headers: {
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
