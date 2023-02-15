enum OrderStatus{
  ready, completed, rejected, paymentPending,responsePending,accepted;
  String toJson() => name;
  static OrderStatus fromJson(String json) => values.byName(json);
}
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
  List<String> items;
  int total;
  String? timeOfOrder;
  bool? category;
  //String timeOfOrder;
  // String category;
  OrderStatus Order_status;

  Orders({required this.restaurant_id,required this.user_id,required this.items,required this.total,required this.Order_status});
  factory Orders.fromJson(Map<String,dynamic> json) {
    return Orders(
        restaurant_id: json['restaurant_id'].toString(),
        user_id: json['user_id'].toString(),
        items: json['items'],
        total: json['total'],
        // isfood: json['suggestedTime'],
        // timeOfOrder: json['timeOfOrder'].toString(),
        // category: json['category'].toString(),
        Order_status: json['Order_status']
    );
  }
}