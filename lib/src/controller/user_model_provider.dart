import 'package:flutter/material.dart';
import 'package:json_parcing/src/controller/database_functions.dart';
import 'package:json_parcing/src/models/user_model.dart';

class UserModelProvider with ChangeNotifier{
  DatabaseFunctions db = DatabaseFunctions.getDatabase();

  Future <bool> addUser(UserModel user)async{
  await db.addUser(user);
  notifyListeners();
  return true;
  }

  Future <bool> editUser(UserModel user)async{
  await db.editUser(user,);
  notifyListeners();
  return true;
  }

  Future <bool> deleteUser(UserModel user)async{
  await db.deleteUser(user);
  notifyListeners();
  return true;
  }

List<UserModel> getUser(){
  return db.getUsers();
}



}