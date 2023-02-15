import 'dart:convert';
import 'dart:io';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/model/shop_verification_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../constants/error_handling.dart';
import '../constants/globvar.dart';
import '../model/dishInfo.dart';

class RestaurantServ {

  void postRestaurant(ShopVerificationInfo info, MyUser? user)async{
    const MONGO_URL = 'http://10.0.2.2:8080';
                        
    Map<String,dynamic> body = {
      'ownerName': user!.fullName,
      'restaurantName': info.shopName,
      'phoneNumber': 'info.phoneNumber',
      'email': user.email,
      'location': info.location,
      'timing': [
        {
          'start_time': info.startTime
        },
        {
          'end_time': info.closeTime
        }
      ],
      'status': 'on',
    };
    Map<String,String> customHeaders = {
      "content-type": "application/json"
    };
    var pobj=jsonEncode(body);
    String url = MONGO_URL + '/food/rest';
    var res = await http.post(Uri.parse(url),headers: customHeaders ,body: pobj);
    print(res.body);
    print('SUCCESS');
  }

  Future<List<RestInfo>> fetchAllRestaurants(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('http://10.0.2.2:8080/food/rest'));
      var obj = jsonDecode(res.body);
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
            RestList.add(RestInfo.fromJson(obj[i]));
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

  Future<List<DishInfo>> fetchDish(
      BuildContext context, List<String>? menu) async {
    // final userProvider = Provider.of(context)
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes = [];
    try {
      for (int i = 0; i < menu!.length; i++) {
        http.Response res = await http.get(
            Uri.parse('http://10.0.2.2:8080/food/dish/${menu[i].toString()}'));
        var obj = jsonDecode(res.body);
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
        );
      }
      ;
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    return dishes;
  }
}
