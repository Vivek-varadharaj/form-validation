import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  String email;
  @HiveField(1)
  String name;
  @HiveField(2)
  String mobile;
  @HiveField(3)
  String? image;

  UserModel({required this.email, required this.image, required this.mobile, required this.name});
  factory UserModel.fromJson(Map json){
    return UserModel(email: json["email"], name: json["fName"], mobile: json["mob"].toString(), image: json["img"], );
  }

}