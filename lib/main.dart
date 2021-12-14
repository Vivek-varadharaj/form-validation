import 'package:flutter/material.dart';
import 'package:json_parcing/controllers/validate.dart';
import 'package:json_parcing/model/user_model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController? _name;
  TextEditingController? _phone;
  TextEditingController? _email;
  UserModel? user;

  bool editStatus = true;

  Validate? valid;

  Map jsonData = {
    "user": {
      "email": "xyz@yyy.com",
      "fName": "demo-man",
      "mob": 9123476833,
      "img":
          "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9jdXN8ZW58MHx8MHx8&w=1000&q=80" // gave a proper link for image
    }
  };
  @override
  void initState() {
    super.initState();
    user = UserModel.fromJson(jsonData["user"]);
    valid = Validate();
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
    _name!.text = user!.name;
    _phone!.text = user!.mobile;
    _email!.text = user!.email;
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
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.network(
                        user!.image,
                        errorBuilder: (context, _, __) => Container(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 7, right: 8, bottom: 8),
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
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
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Name can't be empty.";
                          }
                        },
                        readOnly: editStatus,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _phone,
                        decoration: InputDecoration(
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
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != null) {
                            if (value == "") {
                              return "Email can't be empty";
                            }
                            if (!valid!.validatePhone(value)) {
                              return "Enter valid phone number";
                            }
                          }
                        },
                        readOnly: editStatus,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
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
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != null) if (!valid!.validateEmail(value)) {
                            return "Email not valid";
                          }
                        },
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
                    setState(() {
                      editStatus = false;
                    });
                  },
                  child: Text("Edit"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    setState(() {
                      if (user!.mobile == _phone!.text &&
                          user!.name == _name!.text &&
                          user!.email == _email!.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Data has no change")));
                      } else {
                        user!.email = _email!.text;
                        user!.name = _name!.text;
                        user!.mobile = _phone!.text;

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("New data saved")));
                      }

                      editStatus = true;
                    });
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
