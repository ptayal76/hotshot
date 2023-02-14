// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.items,
    required this.total,
    required this.timeOfOrder,
    required this.orderStatus,
    // required this.v,
  });

  String id;
  String restaurantId;
  String userId;
  List<String> items;
  int total;
  String timeOfOrder;
  String orderStatus;
  // String v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        restaurantId: json["restaurant_id"],
        userId: json["user_id"],
        items: List<String>.from(json["items"].map((x) => (x))),
        total: json["total"] as int,
        timeOfOrder: json["timeOfOrder"],
        // timeOfOrder: TimeOfOrder.fromJson(json["timeOfOrder"]),
        orderStatus: json["Order_status"],
        // v: V.fromJson(json["__v"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurant_id": restaurantId,
        "user_id": userId,
        "items": List<dynamic>.from(items.map((x) => x)),
        "total": total,
        "timeOfOrder": timeOfOrder,
        "Order_status": orderStatus,
        // "__v": v.toJson(),
      };
}

// class TimeOfOrder {
//   TimeOfOrder({
//     required this.date,
//   });

//   Date date;

//   factory TimeOfOrder.fromJson(Map<String, dynamic> json) => TimeOfOrder(
//         date: Date.fromJson(json["\u0024date"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024date": date.toJson(),
//       };
// }

// class Date {
//   Date({
//     required this.numberLong,
//   });

//   String numberLong;

//   factory Date.fromJson(Map<String, dynamic> json) => Date(
//         numberLong: json["\u0024numberLong"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024numberLong": numberLong,
//       };
// }
// class Id {
//   Id({
//     required this.oid,
//   });

//   String oid;

//   factory Id.fromJson(Map<String, dynamic> json) => Id(
//         oid: json["\u0024oid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024oid": oid,
//       };
// }

// class TimeOfOrder {
//   TimeOfOrder({
//     required this.date,
//   });

//   Date date;

//   factory TimeOfOrder.fromJson(Map<String, dynamic> json) => TimeOfOrder(
//         date: Date.fromJson(json["\u0024date"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024date": date.toJson(),
//       };
// }

// class Date {
//   Date({
//     required this.numberLong,
//   });

//   String numberLong;

//   factory Date.fromJson(Map<String, dynamic> json) => Date(
//         numberLong: json["\u0024numberLong"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024numberLong": numberLong,
//       };
// }

// class V {
//   V({
//     required this.numberInt,
//   });

//   String numberInt;

//   factory V.fromJson(Map<String, dynamic> json) => V(
//         numberInt: json["\u0024numberInt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024numberInt": numberInt,
//       };
// }
