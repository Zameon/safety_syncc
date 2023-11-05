import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendRequests extends StatefulWidget {
  @override
  _FriendRequestsScreenState createState() => _FriendRequestsScreenState();

}
String curr_username = "";

class _FriendRequestsScreenState extends State<FriendRequests> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //late String curr_username = "";


  String getUser() {
    final User? user = auth.currentUser;
    print(user?.uid);
    print("atkaye gese?");
    ///for getting the username
    FirebaseFirestore.instance.collection('UserData')
        .where("email", isGreaterThanOrEqualTo: user?.email)
        .get()
        .then((querySnapshot) {
      List<QueryDocumentSnapshot> searchResults = querySnapshot.docs;

      searchResultsList = searchResults;
      curr_username = searchResultsList[0]["username"];
      print(curr_username + "ekhane takao please");

    }).catchError((error) {
      // Handle any errors that occur during the search
      print("Error searching for friends: $error");
    });

    return curr_username;
    // here you write the codes to input the data into firestore
  }

  void _acceptFriendRequest(String friendName) {
    // Implement the logic to send a friend request
    print(curr_username + " " + friendName);
    _firestore.collection('friends').add({
      'user': getUser(), // Replace with the sender's username
      'friend': friendName,
    });
    _firestore.collection('friends').add({
      'user': friendName, // Replace with the sender's username
      'friend': getUser(),
    });

    FirebaseFirestore.instance
        .collection('friend_requests') // Replace with your collection name
        .where('receiver', isEqualTo: getUser())
        .where('sender', isEqualTo: friendName)// Replace with your field and value
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
      print("Documents with specified condition deleted successfully.");
    })
        .catchError((error) {
      print("Error deleting documents: $error");
    });


  }

  void showFriendRequestAcceptedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friend Request Accepted'),
          content: Text('You have accepted the friend request.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<QueryDocumentSnapshot> searchResultsList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Pending Requests'),
            StreamBuilder<QuerySnapshot>(
              //stream: _firestore.collection('UsersData').snapshots(),
              stream: FirebaseFirestore.instance.collection('friend_requests')
                  .where("receiver", isEqualTo: getUser())
                  .where("status", isEqualTo: "pending").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                List<QueryDocumentSnapshot> users = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    String friendName = users[index]['sender'];
                    return ListTile(
                      title: Text(friendName),
                      trailing: IconButton(
                        icon: Icon(Icons.mobile_friendly, color: Colors.green),
                        onPressed: () {
                          print(getUser() + "in friend requests");
                          _acceptFriendRequest(friendName);
                          showFriendRequestAcceptedDialog(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}