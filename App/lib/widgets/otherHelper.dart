
import 'package:hotshot/model/otherInfo.dart';


class OtherHelper{
  static List<OtherInfo> topPicks = topPicksdata
      .map((data) => OtherInfo(ownerName: data['ownerName']!, shopName: data['shopName']!, phoneNumber: data['phoneNumber']!, email: data['email']!, pic: data['pic']!, category: data['category']!, location: data['location']!, status: data['status']!,description: data['description']!)).toList();
  static List<OtherInfo> suggested = suggesteddata
      .map((data) => OtherInfo(ownerName: data['ownerName']!, shopName: data['shopName']!, phoneNumber: data['phoneNumber']!, email: data['email']!, pic: data['pic']!, category: data['category']!, location: data['location']!, status: data['status']!,description: data['description'])).toList();
// static List<RestInfo> hospital = hospitaldata
  //     .map((data) => RestInfo(ownerName: data['ownerName']!, restaurantName: data['restaurantName']!, phoneNumber: data['phoneNumber']!, email: data['email']!, pic: data['pic']!, locationCategory: data['locationCategory']!, location: data['location']!, rating: data['rating']!, status: data['status']!)).toList();
  static List<OtherInfo> hospital = hospitaldata
      .map((data) => OtherInfo(ownerName: data['ownerName']!, shopName: data['shopName']!, phoneNumber: data['phoneNumber']!, email: data['email']!, pic: data['pic']!, category: data['category']!, location: data['location']!, status: data['status']!,description: data['description'])).toList();

}
Set<Map<String,dynamic>> hospitaldata= {
  {
    'ownerName': 'Name1',
    'shopName': ' IITG Hospital',
    'phoneNumber': '8427987645',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/hosp1.jpg',
    'category': 'Hospital',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },

};
Set<Map<String,dynamic>> suggesteddata= {
  {
    'ownerName': 'Name1',
    'shopName': 'Jai Lohit',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/rent1.jpg',
    'category': 'supremacy',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },
  {
    'ownerName': 'Name1',
    'shopName': ' Khokha rentals',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/rent2.jpg',
    'category': 'Hospital',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },
  {
    'ownerName': 'Name1',
    'shopName': ' IITG Hospital',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/hosp199.3.jpg',
    'category': 'Hospital',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },
};
var topPicksdata = {
  {
    'ownerName': 'Name1',
    'shopName': ' Souvenir',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/souv1.jpg',
    'category': 'Hospital',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },
  {
    'ownerName': 'Name1',
    'shopName': ' ABC rents',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/rent2.jpg',
    'category': 'Hospital',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },
  {
    'ownerName': 'Name1',
    'shopName': ' IITG Hospital',
    'phoneNumber': '9998887776',
    'email': 'xxx@gmail.com',
    'pic': 'assets/images/hosp.jpg',
    'category': 'Hospital',
    'location': '1st Floor, Lohit Hostel',
    'status': 'on',
    'description': 'Open 24 x 7 , come any time'
  },
};