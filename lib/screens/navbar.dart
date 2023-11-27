import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/About.dart';
import 'package:safety_syncc/screens/Feedback.dart';
import 'package:safety_syncc/screens/MoodSelectionPage.dart';
import 'package:safety_syncc/screens/SDmain.dart';
import 'package:safety_syncc/screens/community.dart';
import 'package:safety_syncc/screens/signin_screen.dart';
import 'package:safety_syncc/screens/chatRoom.dart';

import 'location.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  String? name;
  String? email;
  final usr = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserData');

  @override

  void initState() {
    super.initState();
    getUsersData(); // Call getUsersData directly in initState
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(name!),
              accountEmail: Text(email!),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('images/user.png'),
                ),
              ) ,
            decoration: BoxDecoration(
              color: Colors.purple[300],
            ),
          ),
          ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location Tracking'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LocationScreen()))
          ),
          ListTile(
              leading: Icon(Icons.add),
              title: Text('Community'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Community()))
          ),
          ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat')
              /*onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => chatRoom())*/
          ),
          ListTile(
              leading: Icon(Icons.safety_check),
              title: Text('Self Defense Tutorials'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SDmain(Title: 'Self Defense',)))
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Meditation'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MoodSelect()))
          ),
          ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text('About Us'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutUsPage(Title: "About Us")))
          ),
          ListTile(
              leading: Icon(Icons.feedback_rounded),
              title: Text('Feedback'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FeedbackPage()))
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign out'),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SignInScreen()))
          ),
        ],
      ),
    );
  }

  getUsersData() async {
    await collectionReference.doc(usr!.uid).get().then((value) {
      setState(() {
        name =  value['username'];
        email = value['email'];
      });
    });
    print(name);
  }
}
