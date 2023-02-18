import 'dart:convert';
import 'dart:io';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/model/shop_verification_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/error_handling.dart';
import '../constants/globvar.dart';
import '../model/dishInfo.dart';
import 'package:hotshot/constants/constants.dart';
import '../model/orderInfo.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:http_parser/http_parser.dart';

//String tokenFinal =
//  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';

// String tokenFinal =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VlNmQwZWYzZDUwYmI3Y2E0OTcyYjUiLCJpYXQiOjE2NzY1Njk4NzB9.A8X6k6Dx4HFaPdxE5zIRq3IpFD4Z9lrv27s4ILa2jCc';



class RestaurantServ {
  //String MONGO_URL = 'http://192.168.50.88:8080';
  void postRestaurant(ShopVerificationInfo info, MyUser? user,File? _image) async {
    String url = MONGO_URL + '/food/rest';
    var req=await http.MultipartRequest('post',Uri.parse(url));
    req.headers.addAll({'Content-Type': 'application/json','Accept': 'application/json'});
    req.files.add(await http.MultipartFile.fromPath('pic', _image!.path,contentType: MediaType.parse("image/png")));
    req.fields['ownerName']=user!.fullName!;
    req.fields['restaurantName']=info.shopName;
    req.fields['phoneNumber']='info.phoneNumber';
    req.fields['email']=user.email!;
    req.fields['location']=info.location;
    req.fields['status']='on';
    req.fields['razorpayCredKey_id']=info.keyId;
    req.fields['razorpayCredKeySecret']=info.secretKey;
    print('***************');
    var res=await req.send();
    print(res.toString());
    var responsed=await http.Response.fromStream(res);
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    var obj=jsonDecode(responsed.body);
    print(responsed.body);
    print(responsed.headers);
    print(obj);
    // Map<String, dynamic> body = {
    //   'ownerName': user!.fullName,
    //   'restaurantName': info.shopName,
    //   'phoneNumber': 'info.phoneNumber',
    //   'email': user.email,
    //   'location': info.location,
    //   'pic':
    //   // 'timing': [
    //   //   {
    //   //     'start_time': info.startTime
    //   //   },
    //   //   {
    //   //     'end_time': info.closeTime
    //   //   }
    //   // ],
    //   'status': 'on',
    //   'razorpayCred': jsonEncode(
    //     {
    //       'Key_id': info.keyId,
    //       'KeySecret': info.secretKey
    //     }
    //   )
    // // };
    // Map<String, String> customHeaders = {"content-type": "application/json"};
    // var pobj = jsonEncode(body);
    // String url = MONGO_URL + '/food/rest';
    // var res =
    //     await http.post(Uri.parse(url), headers: customHeaders, body: pobj);

    SharedPrefs().setToken(responsed.headers['token']!);
    final restID = obj['_id'];
    print(restID);

    await SharedPrefs().setRestId(restID);
    await SharedPrefs().setRestCreated(true);
    print('SUCCESSsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
  }
  // Future<void> postRestaurant(ShopVerificationInfo info, MyUser? user) async {
  //   Map<String, dynamic> body = {
  //     'ownerName': user!.fullName,
  //     'restaurantName': info.shopName,
  //     'phoneNumber': 'info.phoneNumber',
  //     'email': user.email,
  //     'location': info.location,
  //     // 'timing': [
  //     //   {
  //     //     'start_time': info.startTime
  //     //   },
  //     //   {
  //     //     'end_time': info.closeTime
  //     //   }
  //     // ],
  //     'status': 'on',
  //     // 'razorpayCred': jsonEncode(
  //     //   {
  //     //     'Key_id': info.keyId,
  //     //     'KeySecret': info.secretKey
  //     //   }
  //     // )
  //     'razorpayCredKey_id': info.keyId,
  //     'razorpayCredKeySecret': info.secretKey
  //
  //   };
  //   Map<String, String> customHeaders = {"content-type": "application/json"};
  //   var pobj = jsonEncode(body);
  //   String url = MONGO_URL + '/food/rest';
  //   var res =
  //       await http.post(Uri.parse(url), headers: customHeaders, body: pobj);
  //
  //   SharedPrefs().setToken(res.headers['token']!);
  //   final restID = jsonDecode(res.body)['_id'];
  //   print(restID);
  //
  //   await SharedPrefs().setRestId(restID);
  //   await SharedPrefs().setRestCreated(true);
  //   print('************************************SUCCESS*******************************************');
  // }

  Future<List<DishInfo>?> fetchMenu(BuildContext context, String restID) async {
    List<DishInfo> menu = [];

    try {
      //http.Response res = await http.get(Uri.parse('$MONGO_URL'));
      RestInfo restaurant = await fetchRestaurantsbyID(context, restID);

      List<DishInfo> result = await fetchDish(context, restaurant.menu);
      return result;
    } catch (e) {
      //print('ERROR FETCHING MENU');
      //print(e.toString());
      return null;
    }
  }

  Future<List<RestInfo>> fetchAllRestaurants(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res = await http.get(Uri.parse('${MONGO_URL}/food/rest'));
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj.length);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            RestList.add(RestInfo.fromJson(obj[i]));
          }
          // print(RestList);
          //print("hi");
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

  // Future<List<RestInfo>> fetchRestaurantsByRating(BuildContext context,String restid) async {
  //   // final userProvider = Provider.of(context)
  //   List<RestInfo> RestList = [];
  //   try {
  //     http.Response res = await http.put(Uri.parse('${MONGO_URL}/food/rest/rate/${restid}'));
  //     var obj = jsonDecode(res.body);
  //     // print(obj[0].runtimeType);
  //     // print(obj.length);
  //     // print(res.body);
  //     // print(res.body.runtimeType);
  //     // print(res.body.length);
  //     // print("hi1");
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < obj.length; i++) {
  //           // var obj=;
  //           RestList.add(RestInfo.fromJson(obj[i]));
  //         }
  //         // print(RestList);
  //         //print("hi");
  //       },
  //     );
  //   } catch (e) {
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  //     print(e);
  //     print("alpha");
  //     // showSnackBar(BuildContext, e.toString());
  //   }
  //   return RestList;
  // }

  Future<List<RestInfo>> fetchOpenRestaurants(BuildContext context) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res = await http.get(Uri.parse('${MONGO_URL}/food/rest?status=on'));
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj.length);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            RestList.add(RestInfo.fromJson(obj[i]));
          }
          // print(RestList);
          //print("hi");
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
  Future<List<RestInfo>> fetchSearchRestaurants(BuildContext context,String s) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res = await http.get(Uri.parse('${MONGO_URL}/food/rest?name=${s}'));
      var obj = jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj.length);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < obj.length; i++) {
            // var obj=;
            RestList.add(RestInfo.fromJson(obj[i]));
          }
          // print(RestList);
          //print("hi");
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

  Future<RestInfo> fetchRestaurantsbyID(
      BuildContext context, String restid) async {
    // final userProvider = Provider.of(context)
    List<RestInfo> RestList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('${MONGO_URL}/food/rest/$restid'));
      var obj = jsonDecode(res.body);
      // print(obj.runtimeType);
      // print(obj.length);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.l);
      // print("hi1");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // for (int i = 0; i < obj.length; i++) {
          // var obj=;
          RestList.add(RestInfo.fromJson(obj));
          // }
          // print(RestList);
          //print("hi");
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

  Future<List<DishInfo>> fetchDish(
      BuildContext context, List<String>? menu) async {
    // final userProvider = Provider.of(context)
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes = [];
    try {
      if(menu == []){
        return [];
      }
      else{
        for (int i = 0; i < menu!.length; i++) {
          http.Response res = await http
              .get(Uri.parse('${MONGO_URL}/food/dish/${menu[i].toString()}'));
          var obj = jsonDecode(res.body);
          // print(obj[0].runtimeType);
          // print(obj);
          // print(res.body);
          // print(res.body.runtimeType);
          // print(res.body.length);
          //print("hi1");
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

              // print(dishes);
              // print("hi");
            },
          );
        }
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
      print("alpha");
      // showSnackBar(BuildContext, e.toString());
    }
    return dishes;
  }

  Future<void> postCartOrder(BuildContext context, String dishid) async {
    final user = Provider.of<MyUser?>(context, listen: false);
    final tkn = await SharedPrefs().getToken();
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes = [];
    String token = 'Bearer $tkn'; // +

   // print('TOKEN = $tkn');
    //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
    try {
      // for(int i=0;i<menu!.length;i++){
      http.Response res = await http.post(
          Uri.parse(
            '${MONGO_URL}/food/order/add/${dishid}',
          ),
          headers: {'Authorization': token});
      // var obj=jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      //print("hi1");
      switch (res.statusCode) {
        case 200:
          // onSuccess();
          // print("alpha0");
          break;
        case 400:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['msg'])));
          //print("alpha1");
          // showSnackBar(context, );
          break;
        case 500:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['error'])));
          //print("alpha2");
          // showSnackBar(context, jsonDecode(response.body)['error']);
          break;
        default:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
        //print("alpha3");
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

  Future<void> removeCartOrder(BuildContext context, String dishid) async {

    final String tokenFinal = (await SharedPrefs().getToken()) ?? '';

    // final userProvider = Provider.of(context)
    // DishInfo dish=new DishInfo(Rest_Id: 'jjbcnjk', name: 'kuchbhi', price: 99999, InStock: true);
    List<DishInfo> dishes = [];
    String token = 'Bearer $tokenFinal'; // +
    //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc293bmVyIjpmYWxzZSwiaWQiOiI2M2VkMTU2ODBjNTdkZmQ0NGU5MWI0ZjciLCJpYXQiOjE2NzY0ODE4OTZ9.U7DldEuyTdCyX99xbQgpW8YWaCpibKsdfkVCT_7Ppdw';
    try {
      // for(int i=0;i<menu!.length;i++){
      http.Response res = await http.post(
          Uri.parse(
            '${MONGO_URL}/food/order/remove/${dishid}',
          ),
          headers: {'Authorization': token});
      // var obj=jsonDecode(res.body);
      // print(obj[0].runtimeType);
      // print(obj);
      // print(res.body);
      // print(res.body.runtimeType);
      // print(res.body.length);
      // print("hi1");
      switch (res.statusCode) {
        case 200:
          // onSuccess();
          // print("alpha0");
          break;
        case 400:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['msg'])));
          //print("alpha1");
          // showSnackBar(context, );
          break;
        case 500:
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['error'])));
          //print("alpha2");
          // showSnackBar(context, jsonDecode(response.body)['error']);
          break;
        default:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
        //print("alpha3");
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
