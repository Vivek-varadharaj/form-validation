

class Validate{
  Validate.createInstance();
  static final validate = Validate.createInstance();
  factory Validate(){
    return validate;
  }

  bool validateEmail(String email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  bool validatePhone(String phone){
    if(phone.length == 10){
      return RegExp("^[0-9]*\$").hasMatch(phone);
    }
    return false;
  }

  bool validateName(String name){
    return RegExp("").hasMatch(name);
  }
}