import 'package:flutter/material.dart';
import 'package:json_parcing/src/models/validation_model.dart';

class Validate with ChangeNotifier {
  ValidationModel _firstName = ValidationModel(null, null);
  ValidationModel _phone = ValidationModel(null, null);
  ValidationModel _email = ValidationModel(null, null);

  ValidationModel get firstName => _firstName;
  ValidationModel get phone => _phone;
  ValidationModel get email => _email;

  void setEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      _email = ValidationModel(email, null);
    } else {
      _email = ValidationModel(null, "Enter a valid email");
    }
    notifyListeners();
  }

  void setPhone(String phone) {
    if (phone.length == 10) {
      if (RegExp("^[0-9]*\$").hasMatch(phone)) {
        _phone = ValidationModel(phone, null);
        print(phone);
      }
    } else {
      _phone = ValidationModel(null, "Phone number must be 10 digits");
    }
    notifyListeners();
  }

  void setName(String name) {
    if (name.length >= 3) {
      _firstName = ValidationModel(name, null);
    } else {
      _firstName = ValidationModel(null, "Name must be atleast 3 characters");
    }
    notifyListeners();
  }

  bool get isValidEntirely {
    print(_firstName.value);
    print(_email.value);
    print(_phone.value);
    if (_firstName.value != null &&
        _email.value != null &&
        _phone.value != null) {
      return true;
    }
    return false;
  }
}


