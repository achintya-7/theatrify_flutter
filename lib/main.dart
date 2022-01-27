// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:theatrify/pages/event_page.dart';
import 'package:theatrify/pages/form_page.dart';
import 'package:theatrify/pages/home_page.dart';
import 'package:theatrify/utils/routes.dart';
import 'package:appwrite/appwrite.dart';
import 'package:theatrify/utils/theme.dart';

void main() {
  final client = Client();
    client
    .setEndpoint('https://35.226.27.103/v1') // Your Appwrite Endpoint
    .setProject('61eafcf28a615a64f0df');

  final account = Account(client);
    try {
        final res =  account.createAnonymousSession();
        print(res);
    } on AppwriteException catch(e) {
        print(e.message);
    }
      WidgetsFlutterBinding.ensureInitialized();
      runApp(MyApp());

}

class MyApp extends StatelessWidget {

     // Your Appwrite Project ID
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // BUILD THIS SNAPSHOT FOR ERRORS CATHCHING AND LOADING
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Something went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            initialRoute: "/",
            
            theme: Mytheme.darkTheme(context),

            routes: { 
              MyRoutes.eventsRoute: (context) => EventPage(),
              MyRoutes.formRoute: (context) => FormPage(),
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

