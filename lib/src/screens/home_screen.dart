



import 'package:flutter/material.dart';
import 'package:json_parcing/src/models/user_model.dart';
import 'package:json_parcing/src/database/user_model_provider.dart';
import 'package:json_parcing/src/screens/add_user_screen.dart';
import 'package:json_parcing/src/widgets/user_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddUserScreen()));
      },),
      body: Consumer<UserModelProvider>(
        
        builder:(context, userModelProvider, child){ 
          List <UserModel> users = userModelProvider.getUser();
          return ListView.builder(
          itemCount:users.length ,
          itemBuilder: (context,index){
            
        
        return Container(
          child: UserDisplay(users[index]),
        );
            }
      ); },),);}
}

