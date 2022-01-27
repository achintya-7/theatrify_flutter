// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:theatrify/utils/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  clearText() {
    nameController.clear();
    emailController.clear();
    genreController.clear();
    dateController.clear();
    placeController.clear();
  }

  // addition of data
  CollectionReference Events_info =
      FirebaseFirestore.instance.collection("Evenets_info");

  Future<void> addUser() {
    return Events_info.add({
      'name': name,
      'email': email,
      'genre': genre,
      date: 'date',
      'place': place
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Error caused by $error"));
  }

  var name = "";

  var email = "";

  var genre = "";

  var date = "";

  var place = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genreController = TextEditingController();
  final dateController = TextEditingController();
  final placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add event details".text.make(),
        backgroundColor: Vx.black,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                      autofocus: true,
                      maxLength: 24,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Name: ',
                        labelStyle: TextStyle(fontSize: 15.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                      autofocus: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Email: ',
                        labelStyle: TextStyle(fontSize: 15.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Date';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Date: DD-MM-YYYY',
                      labelStyle: TextStyle(fontSize: 15.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pls enter the date";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    autofocus: true,
                    maxLines: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: 'Genre: ',
                      labelStyle: TextStyle(fontSize: 15.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: genreController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pls enter the Genre";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    autofocus: true,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Address: ',
                      labelStyle: TextStyle(fontSize: 15.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: placeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pls enter the Address";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    setState(() {
                                      name = nameController.text;
                                      email = emailController.text;
                                      date = dateController.text;
                                      genre = genreController.text;
                                      place = placeController.text;
                                      addUser();
                                      clearText();
                                    })
                                  }
                              },
                          child: "Register".text.make()),
                      ElevatedButton(
                          onPressed: () => {clearText()},
                          child: "Reset".text.make())
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
