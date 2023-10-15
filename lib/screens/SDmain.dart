import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/Adult.dart';
import 'package:safety_syncc/screens/Women.dart';

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
                      'kidimage', 'Kids and Teenagers',),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded('adultimage', 'Adults'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded('womenimage', 'Women'),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget getExpanded(String image, String text) {
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
              if (text == 'Kids and Teenagers') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SelfDefense(Title: text,)));
              }
              else if(text == 'Adults') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Adult(Title: text)));
              }
              else if(text == 'Women') {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Women(Title: text)));
              }
            }

        ),
      ),
    );
  }
}
