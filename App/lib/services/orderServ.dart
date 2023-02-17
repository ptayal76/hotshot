import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/model/orderInfo.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../constants/error_handling.dart';
import '../constants/globvar.dart';

String tokenFinal =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
String Bearer = 'Bearer ' +
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
String uri = MONGO_URL; //'http://192.168.1.106:8080';

class OrderServ {
  // String MONGO_URL = 'http://10.0.2.2:8080';
  Future<Order> fetchOrderbyId(BuildContext context, String orderId) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    //TOKEN IS OF RESTAURANT
    String Bearer = 'Bearer ' +
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    // print(Bearer);
    try {
      // print('hello');
      String url = MONGO_URL + '/food/order/$orderId';
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          OrderList.add(Order.fromJson(obj));
          // print(OrderList);
          //print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      // print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // print('xxx');
    return OrderList[0];
  }

  Future<Map<String, dynamic>?> checkout(
      BuildContext context, String orderId) async {
    String Bearer = 'Bearer $tokenFinal';
    try {
      String url = MONGO_URL + '/food/order/checkout/$orderId';
      print('hi1');
      http.Response res = await http.put(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      print('hi');
      print(res.body);
      Map<String, dynamic> obj = jsonDecode(res.body);
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // for (int i = 0; i < obj.length; i++) {
          //   // var obj=;
          //   OrderList.add(Order.fromJson(obj[i]));
          // }
          // print(OrderList);
          // print("hi");
        },
      );
      return (obj == null) ? {} : obj;
    } catch (e) {
      print(e);
    }
  }

  Future<void> acknowledge(
      BuildContext context, String orderId, Map<String, dynamic> json) async {
    String Bearer = 'Bearer $tokenFinal';
    try {
      String url = MONGO_URL + '/food/order/acknowledge/$orderId';
      print('hi1');
      http.Response res = await http.put(Uri.parse(url), body: json);
      print('hi');
      print(res.body);
      // Map<String,dynamic> obj = jsonDecode(res.body);
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // for (int i = 0; i < obj.length; i++) {
          //   // var obj=;
          //   OrderList.add(Order.fromJson(obj[i]));
          // }
          // print(OrderList);
          // print("hi");
        },
      );
      // return (obj==null)?{}:obj;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Order>> fetchResponsePendingOrders(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    String Bearer = 'Bearer $tokenFinal'; // +
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    //print(Bearer);
    try {
      //print('hello');
      String url = MONGO_URL + '/food/order?status=responsePending';
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          // print(OrderList);
          //print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // print('xxx');
    return OrderList;
  }

  // Future<List<Order>> fetchAcceptedOrders(BuildContext context) async {
  //   // final userProvider = Provider.of(context)
  //   List<Order> OrderList = [];
  //   //TOKEN IS OF USER
  //   String Bearer = 'Bearer ' +
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
  //   // String Bearer = 'Bearer ' +
  //   //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
  //   print(Bearer);
  //   try {
  //     print('hello');
  //     String url = MONGO_URL + '/food/order?status=accepted';
  //     http.Response res = await http.get(
  //         Uri.parse(url),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': Bearer
  //         });
  //     var obj = jsonDecode(res.body);
  //     print(obj[0].runtimeType);
  //     print(obj);
  //     print(res.body);
  //     // print(res.body.runtimeType);
  //     print(obj.runtimeType);
  //     print(res.body.length);
  //     print("hi1");
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < obj.length; i++) {
  //           // var obj=;
  //           OrderList.add(Order.fromJson(obj[i]));
  //         }
  //         print(OrderList);
  //         print("hi");
  //       },
  //     );
  //   } catch (e) {
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  //     print(e);
  //     print("alpha");
  //     // showSnackBar(BuildContext, e.toString());
  //   }
  //   print('xxx');
  //   return OrderList;
  // }
  Future<List<Order>> fetchUserCart(BuildContext context) async {
    List<Order> OrderList = [];
    //TOKEN IS OF USER
    String Bearer = 'Bearer ' +
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    // print(Bearer);
    try {
      // print('hello');
      String url = MONGO_URL + '/food/order?status=paymentPending';
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          //print(OrderList);
          //print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // print('xxx');
    return OrderList;
  }

  Future<List<Order>> fetchAcceptedOrders(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    String Bearer = 'Bearer ' +
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    //print(Bearer);
    try {
      //print('hello');
      http.Response res = await http
          .get(Uri.parse('$uri/food/order?status=accepted'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          //   print(OrderList);
          // print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      // print(e);
      // print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // print('xxx');
    return OrderList;
  }

  Future<void> AcceptOrders(BuildContext context, String id) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    //String Bearer = 'Bearer ' +
    //  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    //print(Bearer);
    try {
      // print('hello');
      http.Response res =
          await http.put(Uri.parse('$uri/food/rest/accept/${id}'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          // print(OrderList);
          // print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    //print('xxx');
  }

  Future<void> RejectOrders(BuildContext context, String id) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    //String Bearer = 'Bearer ' +
    //  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    //print(Bearer);
    try {
      // print('hello');
      http.Response res =
          await http.put(Uri.parse('$uri/food/rest/reject/${id}'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      //print(obj[0].runtimeType);
      //print(obj);
      //print(res.body);
      // print(res.body.runtimeType);
      //print(obj.runtimeType);
      //print(res.body.length);
      //print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          //print(OrderList);
          //print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    //print('xxx');
  }

  Future<void> Createdish(
      BuildContext context, Map<String, dynamic> mymap) async {
    // final userProvider = Provider.of(context)
    // List<Order> OrderList = [];
    // String Bearer = 'Bearer ' +
    //  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    // print(Bearer);
    try {
      print('hello1234');
      print(mymap['pic']);
      print(mymap['price'].runtimeType);
      var req =
          await http.MultipartRequest('post', Uri.parse('$uri/food/dish'));
      req.headers.addAll({"Authorization": Bearer});
      req.files.add(await http.MultipartFile.fromPath("pic", mymap["pic"],
          contentType: MediaType.parse("image/png")));
      req.fields['name'] = mymap['name'];
      req.fields['price'] = mymap['price'].toString();
      req.fields['suggestedTime'] = mymap['suggestedTime'];
      req.fields['category'] = mymap['category'];
      req.fields['InStock'] = mymap['InStock'].toString();
      var res = await req.send();
      var responsed = await http.Response.fromStream(res);
      var obj = jsonDecode(responsed.body);
      print(obj); // http.Response res = await http.post(
      //     Uri.parse('$uri/food/dish'),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Accept': 'application/json',
      //       'Authorization': Bearer
      //     },
      //     body: jsonEncode(mymap),
      //     );
      //var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: responsed,
        context: context,
        onSuccess: () {
          // for (int i = 0; i < obj.length; i++) {
          //   // var obj=;
          //   OrderList.add(Order.fromJson(obj[i]));
          // }
          // print(OrderList);
          // print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    //print('xxx');
  }

  Future<List<Order>> fetchCompletedOrders(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<Order> OrderList = [];
    String Bearer = 'Bearer ' +
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjp0cnVlLCJpZCI6IjYzZWQxNDZiMWJhODZjNzkwYjQzMGQ1ZCIsImlhdCI6MTY3NjQ4MTY0M30.SE1sBa1XYTEMmmyIPCWSnzRMl-CAEIXyJgc_WFcMpFk';
    // String Bearer = 'Bearer ' +
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VjZTFkMTdlOGI2MzljZTA5MzZmZDEiLCJpYXQiOjE2NzY0Njg2ODl9.aOMv7NFrXVyV0T74wz2zfWsEYXHDqI5kDHcIec-KxZo';
    //print(Bearer);
    try {
      //print('hello');
      http.Response res = await http
          .get(Uri.parse('$uri/food/order?status=completed'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': Bearer
      });
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // // print(res.body.runtimeType);
      // print(obj.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            OrderList.add(Order.fromJson(obj[i]));
          }
          //   print(OrderList);
          // print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      // print(e);
      // print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // print('xxx');
    return OrderList;
  }
}
