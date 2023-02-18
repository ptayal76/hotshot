class ShopVerificationInfo{
  String shopName;
  String shopType;
  String startTime;
  String closeTime;
  String location;
  String locationCategory;
  String phoneNumber;
  String keyId;
  String secretKey;

  ShopVerificationInfo({
    required this.closeTime,
    required this.shopName,
    required this.shopType,
    required this.startTime,
    required this.location,
    required this.locationCategory,
    required this.phoneNumber,
    required this.keyId,
    required this.secretKey
  });
}