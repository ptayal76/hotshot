class RestInfo{
  String ownerName;
  String  restaurantName;
  String phoneNumber;
  String email;
  String pic;
  String locationCategory;
  String location;
  String rating;
  String status;
  RestInfo({required this.ownerName,required this.restaurantName,required this.phoneNumber,required this.email,required this.pic,required this.locationCategory,required this.location,required this.rating,required this.status});
  factory RestInfo.fromJson(Map<String,dynamic> json) {
    return RestInfo(
      ownerName: json['ownerName'].toString(),
      restaurantName: json['restaurantName'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
      email: json['email'].toString(),
      pic: json['pic'].toString(),
      locationCategory: json['locationCategory'].toString(),
      location: json['location'].toString(),
      rating: json['rating'].toString(),
      status: json['status'].toString(),
    );
  }
}