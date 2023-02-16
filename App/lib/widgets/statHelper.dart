
import 'package:hotshot/model/statInfo.dart';

class StatHelper {
  static List<StatInfo> stat = statdata
      .map((data) =>
      StatInfo(ownerName: data['ownerName']!,
          restaurantName: data['restaurantName']!,
          phoneNumber: data['phoneNumber']!,
          email: data['email']!,
          pic: data['pic']!,
          locationCategory: data['locationCategory']!,
          location: data['location']!,
          rating: data['rating']!,
          status: data['status']!)).toList();
}

Set<Map<String,dynamic>> statdata= {
  {'ownerName': 'Name1',
    'restaurantName': 'Core 3 Stationery',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/stat1.webp',
    'locationCategory': 'Core 3',
    'location': '1st Floor, Lohit Hostel',
    'rating': '4.5',
    'status': 'on',

  },
  {'ownerName': 'Name2',
    'restaurantName': 'Lohit Stationery',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/stat2.jpg',
    'locationCategory': 'Lohit Hostel',
    'location': 'Ground Floor, Dihing Hostel',
    'rating': '3.5',
    'status': 'off',

  },
  {'ownerName': 'Name3',
    'restaurantName': 'khokha stationery',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/images.jpg',
    'locationCategory': 'Khokha',
    'location': 'Khokha',
    'rating': '4.0',
    'status': 'on',

  },
};