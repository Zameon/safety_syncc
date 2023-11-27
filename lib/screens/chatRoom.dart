import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_syncc/screens/dateformatting.dart';
import 'package:safety_syncc/screens/location.dart';
import 'package:safety_syncc/screens/chatScreen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class chatRoom extends StatefulWidget {
  @override
  _chatRoomScreenState createState() => _chatRoomScreenState();
}

String curr_username = "";

class _chatRoomScreenState extends State<chatRoom> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //late String curr_username = "";
  Map<String, dynamic> userMap = {};
  Map<String, dynamic> share = {};
  Map<String, dynamic> frnTxts = {};
  Map<String, dynamic> chatData = {};


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

  void getLastMessage(String name, String crid)  {

    final docRef =  _firestore.collection('Chatroom').doc(crid);
    docRef.get().then(
          (DocumentSnapshot doc) {
            setState(() {
              final data = doc.data() as Map<String, dynamic>;
              print("Inside");
              frnTxts = data;
            });

        print("Outside set stat");

        print(frnTxts);
      },
      onError: (e) => print("Error getting document: $e"),
    );

    print(frnTxts);
  }

  void updateData(String friendName, String crid)  {
    // get the document ID
    _firestore.collection("Chatroom").doc(crid).update({"from_num": 0});

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

  List<QueryDocumentSnapshot> searchResultsList = [];
  bool isSharingON = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text('Messages'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('conversations')
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
                    String crid = users[index]['chatRoomID'];
                    getLastMessage(friendName, crid);
                    print("dekhi");
                    print(frnTxts);
                    print("babji");
                    //print(mail);

                    return Card(

                          elevation: 16,
                          shadowColor: Colors.white54,
                          child: ListTile(
                            hoverColor: Colors.white54,
                            focusColor: Colors.purple.shade300,
                            tileColor: Colors.white10,
                            title: Text(friendName),
                            subtitle: Text(frnTxts['last_sendby'] == getUser() ? "You: " + frnTxts['last_message'] : frnTxts['last_message'],
                              style: frnTxts['from_num'] > 0 && frnTxts['last_sendby'] != getUser()  ? TextStyle(
                                fontWeight: FontWeight.bold) : TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                            enabled: true,
                            onTap: ()
                            {
                              _populateUsermap(friendName);
                              print("before going into chatroom: ");
                              print(userMap);
                              print(getChatRoomId(getUser(), friendName));
                              updateData(friendName, crid); // make the whatever it is 0
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
                            //trailing : Column(
                              
                            //),

                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),

                    trailing: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        MyDateUtil.getMessageTime(context: context, time: frnTxts['last_time'].toDate().millisecondsSinceEpoch.toString()),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    )));

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
