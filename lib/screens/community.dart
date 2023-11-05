import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_syncc/screens/FriendSearchScreen.dart';
import 'package:safety_syncc/screens/PendingRequests.dart';
import 'package:safety_syncc/screens/FriendRequests.dart';
import 'package:safety_syncc/screens/friendsList.dart';



class Community extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          title: Text('Community'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.people), text: 'Friends'),
              Tab(icon: Icon(Icons.notifications), text: 'Requests'),
              Tab(icon: Icon(Icons.send_to_mobile), text: 'Pending'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FriendSearchScreen(),
            FriendList(),
            FriendRequests(),
            PendingRequests(),
          ],
        ),
      ),
    );
  }
}

class FriendsListScreen extends StatefulWidget {

  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {


  @override
  void initState() {
    super.initState();
    //_firestore = widget.firestore;
  }

  // Implement the logic to display the list of friends here

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Friends List Screen'),
    );
  }
}

class FriendRequestsScreen extends StatefulWidget {




  @override
  _FriendRequestsScreenState createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
 // late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    //_firestore = widget.firestore;
  }

  // Implement the logic to display the friend requests here

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Friend Requests Screen'),
    );
  }
}
