import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_syncc/screens/location.dart';

class FriendList extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();

}
String curr_username = "";

class _FriendListScreenState extends State<FriendList> {
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

      print("Error searching for friends: $error");
    });

    return curr_username;

  }

  void updateData(bool val, String friendName) {
    // get the document ID
    FirebaseFirestore.instance
        .collection('friends')
        .where('friend', isEqualTo: friendName)
        .where('user', isEqualTo: getUser())
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        print(ds.reference.id + " edike takao");
        FirebaseFirestore.instance
            .collection('friends')
            .doc(ds.reference.id)
            .update({'sharelocation': !val})
            .then((value) {
          print("Value updated successfully.");
        })
            .catchError((error) {
          print("Error updating value: $error");
        });
      }

      print("Document id found.");
    })
        .catchError((error) {
      print("Error finding documents: $error");
    });

  }


  List<QueryDocumentSnapshot> searchResultsList = [];
  bool isSharingON = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Besties'),
            StreamBuilder<QuerySnapshot>(
              //stream: _firestore.collection('UsersData').snapshots(),
              stream: FirebaseFirestore.instance.collection('friends')
                  .where("user", isEqualTo: getUser()).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                List<QueryDocumentSnapshot> users = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    String friendName = users[index]['friend'];
                    return ListTile(
                      title: Text(friendName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: new Icon(isSharingON ? Icons.location_on:Icons.location_off),
                            onPressed: () {
                              // Implement edit functionality
                              updateData(users[index]['sharelocation'], friendName);
                              setState(() {
                                if(users[index]['sharelocation'] == false)
                                  {
                                    isSharingON = false;
                                  }
                                else
                                  {
                                    isSharingON = true;
                                  }
                              });
                              print('Edit item $index');
                       },
                          ),
                          IconButton(
                            icon: Icon(Icons.my_location_sharp),
                            onPressed: () {
                              // Implement delete functionality
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LocationScreen()));
                              print('Delete item $index');
                            },
                          ),
                        ],
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

