class UserModel{
  String email;
  String name;
  String mobile;
  String image;

  UserModel({required this.email, required this.image, required this.mobile, required this.name});
  factory UserModel.fromJson(Map json){
    return UserModel(email: json["email"], name: json["fName"], mobile: json["mob"].toString(), image: json["img"], );
  }

}