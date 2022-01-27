// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:theatrify/utils/routes.dart';
import 'package:theatrify/utils/theme.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    height = height / 2;
    return Scaffold(
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(colors: [
                UtilityColors.primaryColor1,
                UtilityColors.primaryColor2
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter))
              .make(),
          [
            AppBar(
              title: "Theatrify".text.xl5.bold.make().shimmer(
                  primaryColor: Vx.pink800, secondaryColor: Vx.blue300),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ).p(16),

            30.heightBox,

            Image.asset("assets/images/image_2.png",
              fit: BoxFit.cover,
              height: 350,
            
            ),

            40.heightBox,

            ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, MyRoutes.formRoute)},
                child: "Event Assigning".text.xl3.make(),
                style: ElevatedButton.styleFrom(
                    primary: UtilityColors.primaryColor1,
                    shadowColor: Vx.pink400,
                    enableFeedback: true)),
            ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, MyRoutes.eventsRoute)},
                child: "All Events Showcase".text.xl3.make(),
                style: ElevatedButton.styleFrom(
                    primary: UtilityColors.primaryColor3,
                    shadowColor: Vx.pink400,
                    enableFeedback: true)),
          ].vStack(alignment: MainAxisAlignment.start),
        ],
      ),
    );
  }
}
