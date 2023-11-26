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

  late final Map<String, dynamic> userMap;
  late final String chatRoomId;

  Future<void> getSentPeople() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where("sender", isEqualTo: curr_name)
        .get();

    setState(() {

      querySnapshot.docs.forEach((doc) {
        userFriends[doc.get('receiver')] = true;
      });
      print(userFriends);
    });

    return;
  }

  Future<void> getFriends() async {
    await _firestore.collection('UserData').doc(usr!.uid).get().then((value) {
      setState(() {
        curr_name = value['username'];
        print(curr_name);
      });
    });

    getSentPeople();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friends')
        .where("friend", isEqualTo: curr_name)
        .get();

    Map<String, bool> data = {};
    //querySnapshot.docs.forEach((doc) {
    //  data[doc.get('user')] = true;
    //});

    setState(() {
      //userFriends = data;
      querySnapshot.docs.forEach((doc) {
        userFriends[doc.get('user')] = true;
      });
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

        print(inputData() + " " + friendName);
        _firestore.collection('friend_requests').add({
          'sender': inputData(), // Replace with the sender's username
          'receiver': friendName,
          'status': 'pending',
        });

    // Implement the logic to send a friend request

  }

  @override
  void initState() {
    super.initState();
    getFriends();
    ErrorWidget.builder = (FlutterErrorDetails details) => Container();
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

     _firestore
        .collection('UserData')
        .where("username", isEqualTo: query)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print("This is new :");
      print(userMap);
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
                          return Card(
                              child: ListTile(
                            title: Text(friendName),
                            /*trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                print(inputData() + " in friend requests");
                                _sendFriendRequest(friendName);
                                showFriendRequestSentDialog(context);
                              },
                            )*/
                                trailing: FloatingActionButton.extended(
                              label: Text('Add'), // <-- Text

                            backgroundColor: Colors.green,
                            icon: Icon( // <-- Icon
                              Icons.add,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print(inputData() + " in friend requests");
                              _sendFriendRequest(friendName);
                              showFriendRequestSentDialog(context);
                            },
                          ),
                          )
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
