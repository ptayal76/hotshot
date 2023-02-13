// import 'package:hotshot/model/restInfo.dart';
// import 'dishInfo.dart';
// import 'orders.dart';
//
// class RestHelper{
//   static List<RestInfo> topPicks = topPicksdata
//       .map((data) => RestInfo(ownerName: data['ownerName']!, restaurantName: data['restaurantName']!, phoneNumber: data['phoneNumber']!, email: data['email']!, pic: data['pic']!, locationCategory: data['locationCategory']!, location: data['location']!, rating: data['rating']!, status: data['status']!)).toList();
//   static List<DishInfo> suggested = suggesteddata
//       .map((data) => DishInfo(Rest_Id: data['Rest_Id'], name: data['name'], category: data['category'], price: data['price'], suggestedTime: data['suggestedTime'], InStock: data['InStock'], pic: data['pic'])).toList();
//   static List<Orders> cartOrders = cartOrdersData
//       .map((data) => Orders(restaurant_id: data['restaurant_id']!, user_id: data['user_id']!, items: data['items']!, total: data['total']!, isfood: data['isfood']!, Order_status: data['Order_status']!)).toList();
// }
//
// Set<Map<String,dynamic>> cartOrdersData = {
//   {
//     'restaurant_id': '001',
//     'user_id': '001',
//     'items': {
//       'Maggi': 4,
//       'Omelete': 1
//     },
//     'total': 5,
//     'isfood': true,
//     // 'timeOfOrder': '15:18 12/02/2023',
//     // 'category': 'alpha',
//     'Order_status': 'Pending'
//   },
//   {
//     'restaurant_id': '002',
//     'user_id': '002',
//     'items': {
//       'Maggi': 3,
//       'Omelete': 4
//     },
//     'total': 7,
//     'isfood': true,
//     // 'timeOfOrder': '15:18 12/02/2023',
//     // 'category': 'alpha',
//     'Order_status': 'Pending'
//   },
//   {
//     'restaurant_id': '004',
//     'user_id': '001',
//     'items': {
//       'Maggi': 0,
//       'Omelete': 0,
//       'Dosa': 3,
//     },
//     'total': 5,
//     'isfood': true,
//     // 'timeOfOrder': '15:18 12/02/2023',
//     // 'category': 'alpha',
//     'Order_status': 'Pending'
//   },
// };
//
// Set<Map<String,dynamic>> suggesteddata= {
//   {
//     'Rest_Id': '00001',
//     'name': 'Maggi',
//     'category': 'veg',
//     'price': 12,
//     'suggestedTime': 'Lunch',
//     'InStock': true,
//     'pic': 'assets/images/dish1.jpg'
//   },
//   {
//     'Rest_Id': '00002',
//     'name': 'Dosa',
//     'category': 'veg',
//     'price': 40,
//     'suggestedTime': 'Lunch',
//     'InStock': false,
//     'pic': 'assets/images/dish2.jpeg'
//   },
//   {
//     'Rest_Id': '00003',
//     'name': 'Shawarma',
//     'category': 'nonveg',
//     'price': 100,
//     'suggestedTime': 'Lunch',
//     'InStock': true,
//     'pic': 'assets/images/dish3.jpeg'
//   },
// };
// var topPicksdata = {
//   {'ownerName': 'Name1',
//     'restaurantName': 'Lohit Canteen',
//     'phoneNumber': '9998887776',
//     'email': 'xxx@gmail.com',
//     'pic': 'assets/images/rest1.jpg',
//     'locationCategory': 'Lohit Hostel',
//     'location': '1st Floor, Lohit Hostel',
//     'rating': '4.5',
//     'status': 'on',
//
//   },
//   {'ownerName': 'Name2',
//     'restaurantName': 'Dihing Canteen',
//     'phoneNumber': '9998887776',
//     'email': 'xxx@gmail.com',
//     'pic': 'assets/images/rest2.jpg',
//     'locationCategory': 'Dihing Hostel',
//     'location': 'Ground Floor, Dihing Hostel',
//     'rating': '3.5',
//     'status': 'off',
//
//   },
//   {'ownerName': 'Name3',
//     'restaurantName': 'Roasted Pot',
//     'phoneNumber': '9998887776',
//     'email': 'xxx@gmail.com',
//     'pic': 'assets/images/rest3.jpg',
//     'locationCategory': 'Khokha',
//     'location': 'Khokha',
//     'rating': '4.0',
//     'status': 'on',
//
//   },
// };