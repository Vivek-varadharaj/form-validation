import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_parcing/src/database/user_model.dart';

class DatabaseFunctions {
  List<UserModel> newPlaylist = [];
  final Box<UserModel> _allUsersBox = Hive.box("userBox");

  static DatabaseFunctions? _db;
  DatabaseFunctions.getDatabase();

  factory DatabaseFunctions() {
    if (_db == null) {
      _db = DatabaseFunctions.getDatabase();
      return _db!;
    }
    return _db!;
  }

 Future<bool>addUser(UserModel userModel)async{
    await _allUsersBox.put(userModel.email,userModel); 
    return true;
  }

  Future <bool> editUser(UserModel userModel,)async{
    userModel.save();
    return true;

  }
  Future <bool> deleteUser( UserModel user)async{
    await _allUsersBox.delete(user.key);
    return true;

  }

  List<UserModel> getUsers(){
    return _allUsersBox.values.toList();
  }
}
