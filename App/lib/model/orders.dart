
class Orders{
  // String Rest_Id;
  // String  name;
  // String category;
  // int price;
  // String suggestedTime;
  // bool InStock;
  // String pic;
  String restaurant_id;
  String user_id;
  Map items;
  int total;
  bool isfood;
  //String timeOfOrder;
  // String category;
  String Order_status;

  Orders({required this.restaurant_id,required this.user_id,required this.items,required this.total,required this.isfood,required this.Order_status});
  factory Orders.fromJson(Map<String,dynamic> json) {
    return Orders(
        restaurant_id: json['restaurant_id'].toString(),
        user_id: json['user_id'].toString(),
        items: json['items'],
        total: json['total'],
        isfood: json['suggestedTime'],
        // timeOfOrder: json['timeOfOrder'].toString(),
        // category: json['category'].toString(),
        Order_status: json['Order_status'].toString()
    );
  }
}