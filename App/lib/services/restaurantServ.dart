import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../constants/error_handling.dart';
import '../constants/globvar.dart';
import '../model/dishInfo.dart';

class RestaurantServ{
  Future<List<RestInfo>> fetchAllRestaurants(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('http://10.0.2.2:8080/food/rest'));
      var obj=jsonDecode(res.body);
      print(obj[0].runtimeType);
      print(obj.length);
      print(res.body);
      print(res.body.runtimeType);
      print(res.body.length);
      print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            RestList.add(
              RestInfo.fromJson(obj[i])
            );
          }
          print(RestList);
          print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    return RestList;
  }
  Future<RestInfo> fetchRestaurantsbyID(BuildContext context,String restid) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('http://10.0.2.2:8080/food/rest/$restid'));
      var obj=jsonDecode(res.body);
      print(obj.runtimeType);
      // print(obj.length);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.l);
      print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // for (int i = 0; i < obj.length; i++) {
            // var obj=;
            RestList.add(
                RestInfo.fromJson(obj)
            );
          // }
          print(RestList);
          print("hi");
        },
      );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    return RestList[0];
  }
  Future<List<DishInfo>> fetchDish(BuildContext context,List<String>? menu) async {
    // final userProvider = Provider.of(context)
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes=[];
    try {
      for(int i=0;i<menu!.length;i++){
      http.Response res =
      await http.get(Uri.parse('http://10.0.2.2:8080/food/dish/${menu![i].toString()}'));
      var obj=jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
           dishes.add(DishInfo.fromJson(obj));
          // for (int i = 0; i < obj.length; i++) {
          //   // var obj=;
          //   RestList.add(
          //       RestInfo.fromJson(obj[i])
          //   );
          // }

          print(dishes);
          print("hi");

        },
      );};
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    return dishes;
  }

  Future<void> postCartOrder(BuildContext context,String dishid) async {
    // final userProvider = Provider.of(context)
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes=[];
    String token= 'Bearer '+'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
    try {
      // for(int i=0;i<menu!.length;i++){
        http.Response res =
        await http.post(Uri.parse('http://10.0.2.2:8080/food/order/add/${dishid}',),headers: {
            'Authorization': token});
        // var obj=jsonDecode(res.body);
        // print(obj[0].runtimeType);
        // print(obj);
        // print(res.body);
        // print(res.body.runtimeType);
        // print(res.body.length);
        print("hi1");
        switch (res.statusCode) {
          case 200:
          // onSuccess();
            print("alpha0");
            break;
          case 400:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['msg'])));
            print("alpha1");
            // showSnackBar(context, );
            break;
          case 500:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['error'])));
            print("alpha2");
            // showSnackBar(context, jsonDecode(response.body)['error']);
            break;
          default:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
            print("alpha3");
        }
        // httpErrorHandle(
        //   response: res,
        //   context: context,
        //   onSuccess: () {
        //     dishes.add(DishInfo.fromJson(obj));
        //     // for (int i = 0; i < obj.length; i++) {
        //     //   // var obj=;
        //     //   RestList.add(
        //     //       RestInfo.fromJson(obj[i])
        //     //   );
        //     // }
        //
        //     print(dishes);
        //     print("hi");
        //
        //   },
        // );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // return dishes;
  }
  Future<void> removeCartOrder(BuildContext context,String dishid) async {
    // final userProvider = Provider.of(context)
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes=[];
    String token= 'Bearer '+'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
    try {
      // for(int i=0;i<menu!.length;i++){
      http.Response res =
      await http.post(Uri.parse('http://10.0.2.2:8080/food/order/remove/${dishid}',),headers: {
        'Authorization': token});
      // var obj=jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      print("hi1");
      switch (res.statusCode) {
        case 200:
        // onSuccess();
          print("alpha0");
          break;
        case 400:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['msg'])));
          print("alpha1");
          // showSnackBar(context, );
          break;
        case 500:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['error'])));
          print("alpha2");
          // showSnackBar(context, jsonDecode(response.body)['error']);
          break;
        default:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
          print("alpha3");
      }
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     dishes.add(DishInfo.fromJson(obj));
      //     // for (int i = 0; i < obj.length; i++) {
      //     //   // var obj=;
      //     //   RestList.add(
      //     //       RestInfo.fromJson(obj[i])
      //     //   );
      //     // }
      //
      //     print(dishes);
      //     print("hi");
      //
      //   },
      // );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    // return dishes;
  }

  }