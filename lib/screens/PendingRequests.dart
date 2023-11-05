import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsScreenState createState() => _PendingRequestsScreenState();

}
String curr_username = "";

class _PendingRequestsScreenState extends State<PendingRequests> {
  final TextEditingController _searchController = TextEditingController();
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

  void _deleteFriendRequest(String friendName) {
    // Implement the logic to send a friend request
    print(curr_username + " " + friendName);
    FirebaseFirestore.instance
        .collection('friend_requests') // Replace with your collection name
        .where('receiver', isEqualTo: friendName) 
        .where('sender', isEqualTo: getUser())// Replace with your field and value
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
                  .where("sender", isEqualTo: getUser())
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
                    String friendName = users[index]['receiver'];
                    return ListTile(
                      title: Text(friendName),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          print(getUser() + "in friend requests");
                         _deleteFriendRequest(friendName);
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