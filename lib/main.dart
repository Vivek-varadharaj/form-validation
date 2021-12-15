

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_parcing/src/database/database_functions.dart';
import 'package:json_parcing/src/database/user_model.dart';
import 'package:json_parcing/src/database/user_model_provider.dart';

import 'package:json_parcing/src/screens/home_screen.dart';


import 'package:json_parcing/src/validation/validate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   
   Directory dir = await getApplicationDocumentsDirectory();
   Hive.init(dir.path);
    Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>("userBox");
  DatabaseFunctions db = DatabaseFunctions();
    Map jsonData = {
    "user": {
      "email": "xyz@yyy.com",
      "fName": "demo-man",
      "mob": 9123476833,
      "img":
          null // gave a proper link for image
    }
  };
 UserModel user = UserModel.fromJson(jsonData["user"]);
 if(db.getUsers().length==0){
   await db.addUser(user);
 }
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
      create: (context)=> Validate(),),
      ChangeNotifierProvider(
      create: (context)=> UserModelProvider(),),
    ],
   
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
    
  }
}


