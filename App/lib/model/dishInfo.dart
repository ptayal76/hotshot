import 'package:flutter/foundation.dart';

enum Category{
  veg,
  nonveg;
  String toJson() => name;
  static Category fromJson(String json) => values.byName(json);
}
enum SuggestedTime{
  Breakfast,
  Lunch,
  Dinner;
  String toJson() => name;
  static SuggestedTime fromJson(String json) => values.byName(json);
}
class DishInfo{
  String id;
  String? Rest_Id;
  String?  name;
  // Category? category;
  int? price;
  // SuggestedTime? suggestedTime;
  bool? InStock;
  // String? pic;
  DishInfo({required this.id,this.Rest_Id,this.name,this.price,this.InStock});
  factory DishInfo.fromJson(Map<String,dynamic> json) {
    return DishInfo(
      id: json['_id'],
      Rest_Id: json['Rest_Id'].toString(),
      name: json['name'].toString(),
      // category: Category.fromJson(json['category']),
      price: json['price'] as int,
      // suggestedTime: SuggestedTime.fromJson(json['suggestedTime']),
      InStock: json['InStock'],
      // pic: json['pic']['data']['data']
    );
  }
}
