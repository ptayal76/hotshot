// To parse this JSON data, do
//
//     final restInfo = restInfoFromJson(jsonString);

import 'dart:convert';

RestInfo restInfoFromJson(String str) => RestInfo.fromJson(json.decode(str));

String restInfoToJson(RestInfo data) => json.encode(data.toJson());

class RestInfo {
  RestInfo({
    required this.id,
    required this.ownerName,
    required this.restaurantName,
    required this.phoneNumber,
    required this.email,
    this.menu,
    required this.location,
    required this.status,
    // required this.orderTypes,
    this.pic,
    required this.rating,
    this.usersRated,
    this.start_time,
    this.close_time
  });

  String id;
  String ownerName;
  String restaurantName;
  String phoneNumber;
  String email;
  List<String>? menu;
  String location;
  String status;
  String? pic;
  double rating = 0.0;
  List? usersRated;
  String? start_time;
  String? close_time;
  // orderTypes;
  // List<dynamic>? timing;

  factory RestInfo.fromJson(Map<String, dynamic> json) => RestInfo(
        id: json["_id"],
        ownerName: json["ownerName"],
        restaurantName: json["restaurantName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        menu: json['menu'] != null
            ? List<String>.from(
                json['menu']!.map(
                  (x) => x,
                ),
              )
            : [],
        // start_time: json[],
        usersRated: json["usersRated"],
        // List<String>.from(json["menu"].map((x) => x)),
        location: json["location"],
        status: json["status"],
        // orderTypes: OrderTypes.fromJson(json["order_types"]),
        pic: json['pic'] != null ? json["pic"] : null,
        rating: json['rating'],
        
        // timing: json['timing'] != null ? List<String>.from(json['timing']!.map((x) => x,),) : [],
        // List<dynamic>.from(json["timing"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ownerName": ownerName,
        "restaurantName": restaurantName,
        "phoneNumber": phoneNumber,
        "email": email,
        "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x)),
        // menu   != null ? List<String>.from(menu?.map((x) => x,),) : null,
        // List<dynamic>.from(menu.map((x) => x)),
        "location": location,
        "status": status,
        "rating": rating,

        // "order_types": orderTypes.toJson(),
        // "timing":timing == null ? [] : List<dynamic>.from(timing!.map((x) => x)),
        // List<dynamic>.from(timing.map((x) => x)),
      };
}

// class Id {
//   Id({
//     required this.oid,
//   });
//
//   String oid;
//
//   factory Id.fromJson(Map<String, dynamic> json) => Id(
//         oid: json["\u0024oid"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "\u0024oid": oid,
//       };
// }
//
// class OrderTypes {
//   OrderTypes({
//     required this.notCollected,
//     required this.collected,
//     required this.rejected,
//     required this.pending,
//   });
//
//   List<dynamic> notCollected;
//   List<dynamic> collected;
//   List<dynamic> rejected;
//   List<dynamic> pending;
//
//   factory OrderTypes.fromJson(Map<String, dynamic> json) => OrderTypes(
//         notCollected: List<dynamic>.from(json["notCollected"].map((x) => x)),
//         collected: List<dynamic>.from(json["collected"].map((x) => x)),
//         rejected: List<dynamic>.from(json["rejected"].map((x) => x)),
//         pending: List<dynamic>.from(json["pending"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "notCollected": List<dynamic>.from(notCollected.map((x) => x)),
//         "collected": List<dynamic>.from(collected.map((x) => x)),
//         "rejected": List<dynamic>.from(rejected.map((x) => x)),
//         "pending": List<dynamic>.from(pending.map((x) => x)),
//       };
// }
//
// class V {
//   V({
//     required this.numberInt,
//   });
//
//   String numberInt;
//
//   factory V.fromJson(Map<String, dynamic> json) => V(
//         numberInt: json["\u0024numberInt"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "\u0024numberInt": numberInt,
//       };
// }

// class RestInfo{
//   String ownerName;
//   String  restaurantName;
//   String phoneNumber;
//   String email;
//   var menu;
//   var pic;
//   // String locationCategory;
//   String location;
//   // String rating;
//   String status;
//   var order_types;
//   var timing;
//   var __v;
//   RestInfo({required this.ownerName,required this.restaurantName,required this.phoneNumber,required this.email,required this.menu,required this.pic,required this.location,required this.status,required this.order_types,required this.timing,required this.__v});
//   // factory RestInfo.fromJson(Map<String,dynamic> json) {
//   //   return RestInfo(
//   //     ownerName: json['ownerName'].toString(),
//   //     restaurantName: json['restaurantName'].toString(),
//   //     phoneNumber: json['phoneNumber'].toString(),
//   //     email: json['email'].toString(),
//   //     pic: json['pic'],
//   //     // locationCategory: json['locationCategory'].toString(),
//   //     location: json['location'].toString(),
//   //     // rating: json['rating'].toString(),
//   //     status: json['status'].toString(),
//   //   );
//   // }
// }