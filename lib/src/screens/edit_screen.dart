import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_parcing/src/models/user_model.dart';
import 'package:json_parcing/src/controller/user_model_provider.dart';

import 'package:json_parcing/src/validation/validate.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
 final UserModel user;
  EditScreen(this.user);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController? _name;
  TextEditingController? _phone;
  TextEditingController? _email;

  final _formKey = GlobalKey<FormState>();
   ImagePicker _picker = ImagePicker();
  
   var image;
   String? copyPath;

  bool editStatus = true;



  
  @override
  void initState() {
    super.initState();
    
    copyPath = widget.user.image;
    _name = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _name!.text = widget.user.name;
    _email!.text = widget.user.email;
    _phone!.text = widget.user.mobile;
     
    
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
                key:_formKey ,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child:copyPath != null ? Image.file(File(copyPath!), fit: BoxFit.cover,) : Image.asset("assets/user.png",fit: BoxFit.cover,)
                        ),
                        GestureDetector(
                            onTap: () async {
                               image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image == null) return null;
                              setState(() {
                                
                                copyPath= (image.path);
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
                         ) ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 7, right: 8, bottom: 8),
                      child: TextFormField(
                        
                        controller: _name,
                        decoration: InputDecoration(
                          
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
                      onChanged: (value){
                        validateIt.setName(value);
                      },
                        readOnly: editStatus,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value){
                        validateIt.setPhone(value);
                        },
                        controller: _phone,
                        decoration: InputDecoration(
                         
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
                        onChanged: (value){
                          validateIt.setEmail(value);
                        },
                        controller: _email,
                        decoration: InputDecoration(
                          
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    setState(() {
                      editStatus = false;
                    });
                  },
                  child: Text("Edit"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                     validateIt.setEmail(_email!.text);
                     validateIt.setName(_name!.text);
                     validateIt.setPhone(_phone!.text);
                   
                    if(validateIt.isValidEntirely){
                        setState(() {
                         
                      if (widget.user.mobile == _phone!.text &&
                          widget.user.name == _name!.text &&
                          widget.user.email == _email!.text&& widget.user.image ==copyPath) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Data has no change")));
                      } else {
                       
                        widget.user.email = _email!.text;
                        widget.user.name = _name!.text;
                        widget.user.mobile = _phone!.text;
                        widget.user.image =  copyPath;
                        Provider.of<UserModelProvider>(context,listen: false).editUser(widget.user);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("New data saved")));

                            Navigator.of(context).pop();
                      }

                      
                    });
                  };
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