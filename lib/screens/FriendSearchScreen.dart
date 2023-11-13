import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendSearchScreen extends StatefulWidget {
  @override
  _FriendSearchScreenState createState() => _FriendSearchScreenState();
}

class _FriendSearchScreenState extends State<FriendSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //late String curr_username = "";
  final usr = FirebaseAuth.instance.currentUser;
  late String? curr_name;
  late Map<String, bool> userFriends = {};

  Future<void> getFriends() async {
    await _firestore.collection('UserData').doc(usr!.uid).get().then((value) {
      setState(() {
        curr_name = value['username'];
        print(curr_name);
      });
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friends')
        .where("friend", isEqualTo: curr_name)
        .get();

    Map<String, bool> data = {};
    querySnapshot.docs.forEach((doc) {
      data[doc.get('user')] = true;
    });

    setState(() {
      userFriends = data;
      print(userFriends);
    });

    return;
  }

  String inputData() {
    String curr_username = "";
    final User? user = auth.currentUser;
    final uid = user?.uid;
    print(user?.uid);

    ///for getting the username
    FirebaseFirestore.instance
        .collection('UserData')
        .where("email", isGreaterThanOrEqualTo: user?.email)
        .get()
        .then((querySnapshot) {
      List<QueryDocumentSnapshot> searchResults = querySnapshot.docs;
      setState(() {
        searchResultsList = searchResults;
        curr_username = searchResultsList[0]["username"];
        print(curr_username + "ekhane takao please");
      });
    }).catchError((error) {
      // Handle any errors that occur during the search
      print("Error searching for friends: $error");
    });

    return searchResultsList[0]["username"];
    // here you write the codes to input the data into firestore
  }

  void showFriendRequestSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friend Request Sent'),
          content: Text('Your friend request has been sent.'),
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

  void _sendFriendRequest(String friendName) {
    // Implement the logic to send a friend request
    print(inputData() + " " + friendName);
    _firestore.collection('friend_requests').add({
      'sender': inputData(), // Replace with the sender's username
      'receiver': friendName,
      'status': 'pending',
    });
  }

  @override
  void initState() {
    super.initState();
    getFriends();
    // location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    // location.enableBackgroundMode(enable: true);
  }

  List<QueryDocumentSnapshot> searchResultsList = [];

  // Function to search for friends based on the query
  void _searchFriends(String query) {
    FirebaseFirestore.instance
        .collection('UserData')
        .where("username", isGreaterThanOrEqualTo: query)
        .where("username", isLessThan: query + 'z')
        .get()
        .then((querySnapshot) {
      List<QueryDocumentSnapshot> searchResults = querySnapshot.docs;

      setState(() {
        searchResultsList = searchResults;
        print(searchResultsList[0]["username"] + "ekhane takao");
      });
    }).catchError((error) {
      print("Error searching for friends: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for friends',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = _searchController.text;
                    print(query);
                    print(inputData() + "before input");
                    inputData();
                    print(inputData() + " before Search");
                    _searchFriends(query);
                    print(inputData() + "afterSearch");
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Search Results:'),
            StreamBuilder<QuerySnapshot>(
              //stream: _firestore.collection('UsersData').snapshots(),
              stream: FirebaseFirestore.instance
                  .collection('UserData')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .where('username', isLessThan: _searchController.text + 'z')
                  .where('username', isNotEqualTo: curr_name)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                List<QueryDocumentSnapshot> users = snapshot.data!.docs;
                return FutureBuilder(
                  future: getFriends(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> userSnapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        String friendName = users[index]['username'];
                        if (userFriends[friendName] == true) {
                          return Container();
                        } else {
                          return ListTile(
                            title: Text(friendName),
                            trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                print(inputData() + " in friend requests");
                                _sendFriendRequest(friendName);
                                showFriendRequestSentDialog(context);
                              },
                            ),
                          );
                        }
                      },
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

//chole
