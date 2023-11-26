import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_syncc/screens/location.dart';
import 'package:safety_syncc/screens/chatScreen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  Map<String, dynamic> userMap = {};
  Map<String, dynamic> share = {};
  Map<String, String> frnMails = {};

  String getUser() {
    final User? user = auth.currentUser;
    print(user?.uid);
    print("atkaye gese?");

    ///for getting the username
    FirebaseFirestore.instance
        .collection('UserData')
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

  void getemail(String name) {
    Map<String, dynamic> res = {};
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore
        .collection('UserData')
        .where("username", isEqualTo: name)
        .get()
        .then((value) {
      setState(() {
        share = value.docs[0].data();
        frnMails[name] = share["email"];
        //print(mail);
      });

      //print(res);
    });
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
            .update({'sharelocation': !val}).then((value) {
          print("Value updated successfully.");
        }).catchError((error) {
          print("Error updating value: $error");
        });
      }

      print("Document id found.");
    }).catchError((error) {
      print("Error finding documents: $error");
    });
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  void _populateUsermap(String friendname) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore
        .collection('friends')
        .where("friend", isEqualTo: friendname)
        .where("user", isEqualTo: getUser())
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print(userMap);
    });
  }

  void showRequestDeleted(BuildContext context, String friendname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friend Removed'),
          content: Text('You are no longer friends with ' + friendname + '.'),
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

  void locationYES(BuildContext context, String friendname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sharing your location'),
          content: Text('You are sharing location with ' + friendname + '.'),
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

  void locationNO(BuildContext context, String friendname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stopped sharing your location'),
          content: Text(
              'You are no longer sharing location with ' + friendname + '.'),
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

  void _deleteFriend(String friendName) {
    // Implement the logic to send a friend request
    print(curr_username + " " + friendName);
    FirebaseFirestore.instance
        .collection('friends') // Replace with your collection name
        .where('friend', isEqualTo: friendName)
        .where('user',
            isEqualTo: getUser()) // Replace with your field and value
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
      print("Documents with specified condition deleted successfully.");
    }).catchError((error) {
      print("Error deleting documents: $error");
    });

    FirebaseFirestore.instance
        .collection('friends') // Replace with your collection name
        .where('user', isEqualTo: friendName)
        .where('friend',
            isEqualTo: getUser()) // Replace with your field and value
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
      print("Documents with specified condition deleted successfully.");
    }).catchError((error) {
      print("Error deleting documents: $error");
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
              stream: FirebaseFirestore.instance
                  .collection('friends')
                  .where("user", isEqualTo: getUser())
                  .snapshots(),
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
                    bool sharing = users[index]['sharelocation'];
                    getemail(friendName);
                    //print(mail);

                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationScreen()));
                              print('Delete item $index');
                            },
                            backgroundColor: Colors.blue,
                            icon: Icons.my_location_sharp,
                            label: 'Track',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              _populateUsermap(friendName);
                              print("before going into chatroom: ");
                              print(userMap);
                              print(getChatRoomId(getUser(), friendName));
                              // Implement delete functionality
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                          chatRoomId: getChatRoomId(
                                              getUser(), friendName),
                                          userMap: userMap)));
                              print('Send text to $index');
                            },
                            backgroundColor: Colors.blueGrey,
                            icon: Icons.message,
                            label: 'Text',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _deleteFriend(friendName);
                              showRequestDeleted(context, friendName);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Remove',
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 16,
                        shadowColor: Colors.white54,
                          child: ListTile(
                                hoverColor: Colors.white54,
                                focusColor: Colors.purple.shade300,
                                tileColor: Colors.white10,
                                title: Text(friendName),
                                subtitle: Text(frnMails[friendName]!),
                                enabled: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                            IconButton(
                              icon: Icon(sharing
                                  ? Icons.location_on
                                  : Icons.location_off),
                              onPressed: () {
                                print(sharing);
                                print(" with " + friendName);
                                // Implement edit functionality
                                updateData(
                                    users[index]['sharelocation'], friendName);

                                print('Edit item $index');
                              },
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                      )),
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
