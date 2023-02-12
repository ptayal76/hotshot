
class DishInfo{
  String Rest_Id;
  String  name;
  String category;
  int price;
  String suggestedTime;
  bool InStock;
  String pic;
  DishInfo({required this.Rest_Id,required this.name,required this.category,required this.price,required this.suggestedTime,required this.InStock,required this.pic});
  factory DishInfo.fromJson(Map<String,dynamic> json) {
    return DishInfo(
      Rest_Id: json['Rest_Id'].toString(),
      name: json['name'].toString(),
      category: json['category'].toString(),
      price: json['price'],
      suggestedTime: json['suggestedTime'].toString(),
      InStock: json['InStock'],
      pic: json['pic'].toString()
    );
  }
}