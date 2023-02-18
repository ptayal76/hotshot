import 'package:flutter/foundation.dart';

// enum Category {
//   veg,
//   nonveg;

//   String toJson() => name;
//   static Category fromJson(String json) => values.byName(json);
// }

// enum SuggestedTime {
//   Breakfast,
//   Lunch,
//   Dinner;

//   String toJson() => name;
//   static SuggestedTime fromJson(String json) => values.byName(json);
// }
class DishInfo{
  String id;
  String? Rest_Id;
  String? name;
  String? suggestedTime;
  String? category;
  int? price;
  List<dynamic>? pic;

  // SuggestedTime? suggestedTime;
  bool? InStock;
  // String? pic;
  DishInfo({required this.category, required this.suggestedTime, required this.id,this.Rest_Id,this.name,this.price,this.InStock,this.pic});
  factory DishInfo.fromJson(Map<String,dynamic> json) {
    return DishInfo(
      category: json['category'],
      id: json['_id'],
      Rest_Id: json['Rest_Id'].toString(),
      name: json['name'].toString(),
      // category: Category.fromJson(json['category']),
      price: json['price'] as int,
      suggestedTime: json['suggestedTime'],
      InStock: json['InStock'],
      pic: json['pic'] != null ?json["pic"]["data"]["data"]:null,
      // pic: json['pic']['data']['data']
    );
  }
}


// class DishInfo{
//   String Rest_Id;
//   String  name;
//   String category;
//   int price;
//   String suggestedTime;
//   bool InStock;
//   String pic;
//   DishInfo({required this.Rest_Id,required this.name,required this.category,required this.price,required this.suggestedTime,required this.InStock,required this.pic});
//   factory DishInfo.fromJson(Map<String,dynamic> json) {
//     return DishInfo(
//       Rest_Id: json['Rest_Id'].toString(),
//       name: json['name'].toString(),
//       category: json['category'].toString(),
//       price: json['price'],
//       suggestedTime: json['suggestedTime'].toString(),
//       InStock: json['InStock'],
//       pic: json['pic'].toString()
//     );
//   }
// }
