import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_parcing/src/models/user_model.dart';
import 'package:json_parcing/src/database/user_model_provider.dart';

import 'package:json_parcing/src/validation/validate.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController? _name;
  TextEditingController? _phone;
  TextEditingController? _email;

  bool editStatus = false;
  ImagePicker _picker = ImagePicker();
  File? _image;
  var image;

  @override
  void initState() {
    super.initState();

    _name = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name!.dispose();
    _email!.dispose();
    _phone!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validateIt = Provider.of<Validate>(context);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://dm0qx8t0i9gc9.cloudfront.net/thumbnails/image/rDtN98Qoishumwih/beach-summer-background-abstract-background-wallpaper-use-for-presentation_rPTI0gu2zl_thumb.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
              child: Form(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                            height: 300,
                            width: 300,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset("assets/user.png")),
                        GestureDetector(
                          onTap: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image == null) return null;
                            setState(() {
                              _image = File(image.path);
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text("Tap to add Image"),
                              ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 7, right: 8, bottom: 8),
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: "Name",
                          errorText: validateIt.firstName.error,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              width: 2.0,
                              color: editStatus ? Colors.black : Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: editStatus ? Colors.black : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: editStatus ? Colors.red : Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          validateIt.setName(value);
                        },
                        readOnly: editStatus,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          validateIt.setPhone(value);
                        },
                        controller: _phone,
                        decoration: InputDecoration(
                          hintText: "Mobile",
                          errorText: validateIt.phone.error,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              width: 2.0,
                              color: editStatus ? Colors.black : Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: editStatus ? Colors.black : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: editStatus ? Colors.red : Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                        readOnly: editStatus,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          validateIt.setEmail(value);
                        },
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: "email",
                          errorText: validateIt.email.error,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              width: 2.0,
                              color: editStatus ? Colors.black : Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: editStatus ? Colors.black : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: editStatus ? Colors.red : Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                        readOnly: editStatus,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    
                    if (validateIt.isValidEntirely) {
                      setState(() {
                        UserModel user = UserModel(
                            email: _email!.text,
                            image: image != null ? image.path : null,
                            mobile: _phone!.text,
                            name: _name!.text);

                        Provider.of<UserModelProvider>(context, listen: false)
                            .addUser(user);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("New data saved")));
                        editStatus = true;
                        Navigator.of(context).pop();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Every field is mandatory")));
                    }
                     ;
                  },
                  child: Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
