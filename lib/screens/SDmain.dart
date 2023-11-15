import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/Adult.dart';
import 'package:safety_syncc/screens/Women.dart';
import 'package:safety_syncc/screens/animation.dart';

import 'SelfDefense.dart';
import 'location.dart';

class SDmain extends StatefulWidget {
  String Title;

  SDmain({required this.Title});

  @override
  State<SDmain> createState() => _SDmainState();
}

class _SDmainState extends State<SDmain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(
          child: Text(
            'Self Defense',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[300]!, Colors.purple[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getExpanded('kidimage', 'Kids and Teenagers'),
            getExpanded('adultimage', 'Adults'),
            getExpanded('womenimage', 'Women'),
          ],
        ),
      ),
    );
  }

  Widget getExpanded(String image, String text) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 10, top: 15, right: 15, bottom: 15),
        child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'images/$image.png',
                        height: 100
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
                  ],

                ),
              ),
              // margin: EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.purple[400],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
            onPressed: () {
              if (text == 'Kids and Teenagers') {
                Navigator.push(
                  context,
                  CustomPageRoute(pageBuilder: (context, animation, secondaryAnimation) {
                    return SelfDefense(Title: text);
                  }),
                );
              }
              else if(text == 'Adults') {
                Navigator.push(
                  context,
                  CustomPageRoute(pageBuilder: (context, animation, secondaryAnimation) {
                    return Adult(Title: text);
                  }),
                );
              }
              else if(text == 'Women') {
                Navigator.push(
                  context,
                  CustomPageRoute(pageBuilder: (context, animation, secondaryAnimation) {
                    return Women(Title: text);
                  }),
                );
              }
            }

        ),
      ),
    );
  }
}
