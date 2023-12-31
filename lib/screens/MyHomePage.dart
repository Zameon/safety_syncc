import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/About.dart';
import 'package:safety_syncc/screens/Feedback.dart';
import 'package:safety_syncc/screens/MoodSelectionPage.dart';
import 'package:safety_syncc/screens/SDmain.dart';
import 'package:safety_syncc/screens/chatRoom.dart';
import 'package:safety_syncc/screens/community.dart';
import 'package:safety_syncc/screens/navbar.dart';

import 'SelfDefense.dart';
import 'location.dart';
//import 'SubPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(
          child: Text(
            'Safety Sync',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded(
                      'img1', 'Tracking', 'Share your location'),
                  getExpanded('img2', 'Self Defense', 'Tutorials'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded('img3', 'Community', 'Connect with people'),
                  getExpanded('img4', 'Meditation', 'Tutorials'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded('img5', 'About Us', 'Learn more'),
                  getExpanded('img6', 'Feedback', 'Share your thoughts'),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
      );
  }

  Widget getExpanded(String image, String text, String subtext) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'images/$image.png',
                        height: 80
                    ),
                    SizedBox(height: 10,),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      subtext,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],

                ),
              ),
              // margin: EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.purple[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow:
                  [
                    BoxShadow(),
                  ]
              ),
            ),
            onPressed: () {
              if (text == 'Self Defense') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SDmain(Title: text,)));
              }
              else if(text == 'Tracking') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LocationScreen()));
              }
              else if(text == 'Meditation') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MoodSelect()));
              }
              else if(text == 'About Us') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AboutUsPage(Title: text,)));
              }
              else if(text == 'Feedback') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => FeedbackPage()));
              }
              else if(text == 'Community') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Community()));
              }
            }

        ),
      ),
    );
  }
}