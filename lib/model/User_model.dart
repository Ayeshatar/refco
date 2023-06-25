import 'dart:collection';

class UserModel {
  String? email;
  String? password;
  String? name;
  String? referralCode;
  String? myReferCode;
  String? referredBy;
  int? countRefer;
  String? image;


  UserModel({
    this.email,
    this.password,
    this.referralCode,
    this.name,
    this.countRefer,
    this.image,
    this.myReferCode,
    UserModel? leftChild,
    UserModel? rightChild, required String referredBy,
  });

  factory UserModel.fromJson(Map<String, dynamic> parsedJson,) {
    return UserModel(
      email: parsedJson["email"],
      referralCode: parsedJson["referralCode"],
      referredBy:parsedJson["referredBy"],
      name: parsedJson["name"],
      countRefer: parsedJson["countRefer"] ?? null,
      myReferCode: parsedJson["myReferCode"] ?? null,
    );
  }

  Map<String, dynamic> UserToMap() {
    Map<String, dynamic> map = new HashMap<String, dynamic>();
    map["email"] = this.email;
    map["name"] = this.name;
    map["referralCode"] = this.referralCode;
    map["myReferCode"] = this.myReferCode;
    map["referredBy"]=this.referredBy;
    map["countRefer"] = this.countRefer;
    return map;
  }
}
