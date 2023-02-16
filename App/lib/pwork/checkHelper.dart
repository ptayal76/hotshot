import 'package:hotshot/pwork/checkInfo.dart';



class RestHelper{
  static List<CheckInfo> suggested = suggesteddata
      .map((data) => CheckInfo(Rest_Id: data['Rest_Id'], name: data['name'], category: data['category'], price: data['price'], suggestedTime: data['suggestedTime'], InStock: data['InStock'], pic: data['pic'],amount: data['amount'],)).toList();
}
Set<Map<String,dynamic>> suggesteddata= {
  {
    'Rest_Id': '00001',
    'name': 'Maggi',
    'category': 'veg',
    'price': 12,
    'suggestedTime': 'Lunch',
    'InStock': true,
    'pic': 'assets/images/dish1.jpg',
    'amount':3,
  },
  {
    'Rest_Id': '00002',
    'name': 'Dosa',
    'category': 'veg',
    'price': 40,
    'suggestedTime': 'Lunch',
    'InStock': false,
    'pic': 'assets/images/dish2.jpeg',
    'amount':3,
  },
  {
    'Rest_Id': '00003',
    'name': 'Shawarma',
    'category': 'nonveg',
    'price': 100,
    'suggestedTime': 'Lunch',
    'InStock': true,
    'pic': 'assets/images/dish3.jpeg',
    'amount':3,
  },
};