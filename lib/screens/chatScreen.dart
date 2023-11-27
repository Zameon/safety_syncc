import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:safety_syncc/screens/mymap.dart';
import 'package:safety_syncc/screens/dateformatting.dart';

class ChatRoom extends StatelessWidget {
  Map<String, dynamic> userMap;
  final String chatRoomId;
  String name = "";

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;
  bool isFirstMessage = false;
  Map<String, dynamic> chatData = {};

  String getUsersData() {
    _firestore
        .collection('UserData')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      name = value['username'];
    });

    return name;
  }

  /*Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": _auth.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
    FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }*/

  String getuid(String fname) {
    QuerySnapshot querySnapshot = FirebaseFirestore.instance
        .collection('UserData')
        .where('username', isEqualTo: fname)
        .get() as QuerySnapshot<Object?>;

    if (querySnapshot.docs.isNotEmpty) {
      // The email exists in the database
      String uid = querySnapshot.docs.first.id;
      print("eije " + uid);
      return uid;
    } else {
      print("ashenai");
      // The email does not exist in the database
      return "";
    }
  }

  void onSendMessage()  {

    final docRef = _firestore.collection('Chatroom').doc(chatRoomId);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("Inside");

        chatData = data;
        print(chatData);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    print("Outside");
    print(chatData);

    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": userMap['user'],
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      print("choltese?");

      if(isFirstMessage == true)
        {
          print("prothombar");
          Map<String, dynamic> newEntry = {
            "from_user": userMap['user'],
            "to_user": userMap['friend'],
            "from_num": 1,
            "to_num": 0,
            "last_message": _message.text,
            "last_time": FieldValue.serverTimestamp(),
            "last_sendby": userMap['user']
          };

           _firestore
          .collection('Chatroom')
          .doc(chatRoomId)
          .set(newEntry, SetOptions(merge: true));
          isFirstMessage = false;
        }
      else
        {
          print("puran manush");
          print(chatData);
          if(chatData['from_user'] == userMap['user'])
            {
              Map<String, dynamic> Entry = {
                "from_user": chatData['from_user'],
                "to_user": chatData['to_user'],
                "from_num": chatData['from_num']+1,
                "to_num": chatData['to_num'],
                "last_message": _message.text,
                "last_time": FieldValue.serverTimestamp(),
                "last_sendby": userMap['user']
              };

               _firestore
                  .collection('Chatroom')
                  .doc(chatRoomId)
                  .set(Entry, SetOptions(merge: true));
            }
          else
            {
              Map<String, dynamic> Entry2 = {
                "from_user": chatData['from_user'],
                "to_user": chatData['to_user'],
                "from_num": chatData['from_num']+1,
                "to_num": chatData['to_num']+1,
                "last_message": _message.text,
                "last_time": FieldValue.serverTimestamp(),
                "last_sendby": userMap['user']
              };

               _firestore
                  .collection('Chatroom')
                  .doc(chatRoomId)
                  .set(Entry2, SetOptions(merge: true));
            }
        }

      print("maybe");

      _message.clear();
       _firestore
          .collection('Chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection("UserData")
              .doc(_auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                color: Colors.purple.shade300,
                child: Column(
                  children: [
                    Text(userMap['friend']),
                    /*Text(
                      snapshot.data!['status'],
                      style: TextStyle(fontSize: 14),
                    ),*/
                  ],
                ),
              );
            } else {
              print("ekhane shomosha");
              return Container();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    print(" list make");
                    if(isFirstMessage != true) isFirstMessage = false;
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        print(map);
                        print("ekhane ashe prothombare keno");
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    print("prothombar ");
                    print(isFirstMessage);
                    print("thik korar por");

                    isFirstMessage = true;
                    print(isFirstMessage);
                    return Container(

                    );
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //height: size.height / 17,
                      //width: size.width / 1.7,
                      child: Expanded(
                          child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _message,
                        decoration: InputDecoration(
                            //suffixIcon: IconButton(
                            //onPressed: () => getImage(),
                            //icon: Icon(Icons.photo),
                            //),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      )),
                    ),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          icon: Icon(Icons.send), onPressed: onSendMessage),
                      IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          print("we get the uid as: ");
                          print(getuid(userMap['friend']));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MyMap(getuid(userMap['friend'])),
                          ));
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ?
           Column(
               //crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
             children: [
             Flexible(
                child: Container(
              width: size.width,
              alignment: map['sendby'] == getUsersData()
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  border: map['sendby'] == getUsersData()
                      ? Border.all(color: Colors.white)
                      : Border.all(color: Colors.purple),
                  borderRadius: map['sendby'] == getUsersData()
                      ? BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))
                      : BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                  color: map['sendby'] == getUsersData()
                      ? Colors.purple
                      : Colors.white,
                ),
                child: Text(
                  map['message'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: map['sendby'] == getUsersData()
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            )
          ),
    /*Padding(

    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .04),
    child: Text("time sent",
    style: const TextStyle(fontSize: 13, color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    ),*/
               Container(
                 width: size.width,
                 alignment: map['sendby'] == getUsersData()
                     ? Alignment.centerRight
                     : Alignment.centerLeft,
                 child: Container(
                   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                   child: Text(
                     MyDateUtil.getMessageTime(context: context, time: map['time'].toDate().millisecondsSinceEpoch.toString()),
                     style: TextStyle(
                       fontSize: 13,
                       fontWeight: FontWeight.w500,
                       color: Colors.black,
                     ),
                   ),
                 ),
               )
           ])
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == getUsersData()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            /*child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShowImage(
              imageUrl: map['message'],
            ),
          ),
        ),
        child: Container(
          height: size.height / 2.5,
          width: size.width / 2,
          decoration: BoxDecoration(border: Border.all()),
          alignment: map['message'] != "" ? null : Alignment.center,
          child: map['message'] != ""
              ? Image.network(
            map['message'],
            fit: BoxFit.cover,
          )
              : CircularProgressIndicator(),
        ),
      ),*/
          );
  }
}

/*class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}*/

//
