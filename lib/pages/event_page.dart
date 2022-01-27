// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, avoid_unnecessary_containers

import 'package:appwrite/appwrite.dart';
import 'package:flutter/services.dart';
import 'package:theatrify/model_sendInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:theatrify/utils/theme.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Client appWriteClient;
  late Database database;

  @override
  void initState() {
    super.initState();
    appWriteClient = Client()
        .setEndpoint('https://35.226.27.103/v1')
        .setProject('61eafcf28a615a64f0df')
        .setSelfSigned();
    database = Database(appWriteClient);
  }

  final _formKey2 = GlobalKey<FormState>();

  final Stream<QuerySnapshot> eventStream =
      FirebaseFirestore.instance.collection('Evenets_info').snapshots();

  String email_sub = "";

  clearText() {
    emailController2.clear();
  }

  final emailController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: eventStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Scaffold(
            body: Stack(
              children: [
                VxAnimatedBox()
                    .size(context.screenWidth, context.screenHeight)
                    .withGradient(LinearGradient(colors: [
                      UtilityColors.primaryColor1,
                      UtilityColors.primaryColor2
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))
                    .make(),
                [
                  AppBar(
                    title: "Upcoming Events".text.xl3.bold.make().shimmer(
                        primaryColor: Vx.white, secondaryColor: Vx.white),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                  ).p(16),
                ].vStack(alignment: MainAxisAlignment.start),
                30.heightBox,
                VxSwiper.builder(
                    itemCount: storedocs.length,
                    aspectRatio: 1,
                    enlargeCenterPage: true,
                    itemBuilder: (context, index) {
                      final rad = storedocs[index];

                      return VxBox(
                              child: ZStack([
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: VxBox(
                                  child: rad['genre']
                                      .toString()
                                      .text
                                      .make()
                                      .px16())
                              .height(35)
                              .black
                              .withRounded(value: 10)
                              .black
                              .alignCenter
                              .make(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VStack(
                            [
                              rad['date'].toString().text.xl3.white.bold.make(),
                              5.heightBox,
                              rad['place']
                                  .toString()
                                  .text
                                  .sm
                                  .xl
                                  .white
                                  .bold
                                  .make()
                                  .pOnly(right: 20, left: 20),
                              20.heightBox,
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: VStack([
                            rad['name'].toString().text.white.xl4.bold.make(),
                            10.heightBox,
                          ]),
                        )
                      ]))
                          .clip(Clip.antiAlias)
                          .bgImage(DecorationImage(
                              image: NetworkImage(
                                  "https://media.istockphoto.com/photos/theatre-curtains-background-picture-id173588123?b=1&k=20&m=173588123&s=170667a&w=0&h=v5hk2I3ACNaWSn0VZeD39iwQ6uLSrf-qb0Dfezr4bNM="),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken)))
                          .withRounded(value: 55)
                          .border(color: Colors.black, width: 4.5)
                          .make()
                          .p(16);
                    }).centered(),
                5.heightBox,
                Container(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Form(
                              key: _formKey2,
                              child: TextFormField(
                                  style: TextStyle(color: Vx.purple900),
                                  autofocus: false,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Vx.white,
                                    labelText:
                                        'Enter your email to subscribe to the Newsletter',
                                    labelStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Vx.purple900),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Vx.purple900)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Vx.purple900)),
                                    focusColor: Vx.purple900,
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0),
                                    iconColor: Vx.purple900,
                                  ),
                                  controller: emailController2,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Pls enter your email";
                                    } else if (!value.contains("@")) {
                                      return "Pls enter a valid email";
                                    }
                                    return null;
                                  })).pOnly(left: 6, right: 8, bottom: 2),
                          ElevatedButton(
                              onPressed: () => {
                                    if (_formKey2.currentState!.validate())
                                      {
                                        setState(() {
                                          email_sub = emailController2.text;
                                          model_sendInfo email_id =
                                              model_sendInfo(
                                                  emails: email_sub.replaceAll(
                                                      ' ', ''));
                                          try {
                                            Future result =
                                                database.createDocument(
                                                    collectionId:
                                                        "61eafd364852a5bccadb",
                                                    documentId: "unique()",
                                                    data: email_id.toJson());

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Subscribed"),
                                            ));
                                            
                                          } catch (e) {
                                            print(e);
                                          }

                                          // Future result =
                                          //     database.createDocument(
                                          //         collectionId:
                                          //             "61eafd364852a5bccadb",
                                          //         documentId: "unique()",
                                          //         data: email_id.toJson());

                                          // result.catchError((error) {
                                          //   print(error);
                                          // });



                                          clearText();
                                        })
                                      }
                                  },
                              child: "Subscribe".text.make())
                        ],
                      )),
                )
              ],
            ),
          );
        });
  }
}
