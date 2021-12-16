import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_parcing/src/models/user_model.dart';
import 'package:json_parcing/src/controller/user_model_provider.dart';
import 'package:json_parcing/src/screens/edit_screen.dart';
import 'package:provider/provider.dart';

class UserDisplay extends StatelessWidget {
 final UserModel user;
  UserDisplay(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        tileColor: Colors.blue.withOpacity(0.5),
        leading: user.image != null
            ? CircleAvatar(
                backgroundImage: FileImage(File(user.image!)),
              )
            : CircleAvatar(
                backgroundImage: AssetImage("assets/user.png"),
              ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Delete?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Provider.of<UserModelProvider>(context,
                                      listen: false)
                                  .deleteUser(user);
                              Navigator.of(context).pop();
                            },
                            child: Text("Confirm"))
                      ],
                    ));
          },
          child: Icon(Icons.delete),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditScreen(user)));
        },
      ),
    );
  }
}
