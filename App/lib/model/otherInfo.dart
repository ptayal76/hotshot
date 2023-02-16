class OtherInfo{
  String ownerName;
  String  shopName;
  String phoneNumber;
  String email;
  String pic;
  String category;
  String location;
  String status;
  String description;
  OtherInfo({required this.ownerName,required this.shopName,required this.phoneNumber,required this.email,required this.pic,required this.category,required this.location,required this.status,required this.description});
  factory OtherInfo.fromJson(Map<String,dynamic> json) {
    return OtherInfo(
      ownerName: json['ownerName'].toString(),
      shopName: json['restaurantName'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
      email: json['email'].toString(),
      pic: json['pic'].toString(),
      category: json['locationCategory'].toString(),
      location: json['location'].toString(),
      status: json['status'].toString(),
      description: json['description'].toString(),
    );
  }
}