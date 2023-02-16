
class CheckInfo{
  String Rest_Id;
  String  name;
  String category;
  int price;
  String suggestedTime;
  bool InStock;
  String pic;
  int amount;
  CheckInfo({required this.Rest_Id,required this.name,required this.category,required this.price,required this.suggestedTime,required this.InStock,required this.pic,required this.amount});
  factory CheckInfo.fromJson(Map<String,dynamic> json) {
    return CheckInfo(
        Rest_Id: json['Rest_Id'].toString(),
        name: json['name'].toString(),
        category: json['category'].toString(),
        price: json['price'],
        suggestedTime: json['suggestedTime'].toString(),
        InStock: json['InStock'],
        pic: json['pic'].toString(),
      amount:json['amount'],
    );
  }
}