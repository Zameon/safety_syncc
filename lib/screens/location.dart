import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../screens/mymap.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

//tring curr_username = "";

class _LocationScreenState extends State<LocationScreen> {
  final loc.Location location = loc.Location();
  late String? lat;
  late String? long;
  late String? name;
  late String? curr_username;
  late bool? isFriend;
  StreamSubscription<loc.LocationData>? _locationSubscription;
  final usr = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserData');
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot> searchResultsList = [];
  late Map<String, bool> userFriends;

  ///EDIKE TAKA SAD
  Future<void> getUser() async {
    await collectionReference.doc(usr!.uid).get().then((value) {
      setState(() {
        curr_username =  value['username'];
        print(curr_username);
      });
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friends')
        .where("friend", isEqualTo: curr_username)
        .where("sharelocation", isEqualTo: true)
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

  @override
  void initState() {
    super.initState();
    _requestPermission();
    getUser();

    // location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    // location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text('Live Location Tracker'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
                },
              child: Text('Add My Location')),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: Text('Enable Live Location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('Stop Live Location')),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return FutureBuilder(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot<void> userSnapshot) {

                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        print(userFriends);

                        if (userFriends == null ||
                            (snapshot.data != null &&
                                snapshot.data!.docs.isNotEmpty &&
                                userFriends[snapshot.data!.docs[index]['name'].toString()] == true) || curr_username == snapshot.data!.docs[index]['name'].toString() ) {
                          print("not outside friends with " +
                              snapshot.data!.docs[index]['name'].toString());
                          return ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['name'].toString()),
                            subtitle: Row(
                              children: [
                                Text(snapshot.data!.docs[index]['latitude']
                                    .toString()),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(snapshot.data!.docs[index]['longitude']
                                    .toString()),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.directions),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyMap(snapshot.data!.docs[index].id),
                                ));
                              },
                            ),
                          );
                        }
                        else
                          {
                            return Container();
                          }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _getLocation() async {
    getUsersData();
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc(usr!.uid).set({
        'latitude': '--',
        'longitude': '--',
        'name': name
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }

  }

  Future<void> getUsersData() async {
    await collectionReference.doc(usr!.uid).get().then((value) {
      setState(() {
        name =  value['username'];
      });
    });
  }


  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc(usr!.uid).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': name
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }


}



/*Expanded(
child: StreamBuilder(
stream:
FirebaseFirestore.instance.collection('location').snapshots(),
builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
if (!snapshot.hasData) {
return Center(child: CircularProgressIndicator());
}

return ListView.builder(
itemCount: snapshot.data?.docs.length,
itemBuilder: (context, index) {
getUser();
print(index);
//print(name);
//if(areFriends(snapshot.data!.docs[index]['name'].toString()) == false)
/*areFriends(snapshot.data!.docs[index]['name'].toString());*/
if(userFriends == null || userFriends![snapshot.data!.docs[index]['name'].toString()] == false)
{
print("not friends with " + snapshot.data!.docs[index]['name'].toString());
return Container();
}
print("friends with " + snapshot.data!.docs[index]['name'].toString());
return ListTile(
title:
Text(snapshot.data!.docs[index]['name'].toString()),
subtitle: Row(
children: [
Text(snapshot.data!.docs[index]['latitude']
    .toString()),
SizedBox(
width: 20,
),
Text(snapshot.data!.docs[index]['longitude']
    .toString()),
],
),
trailing: IconButton(
icon: Icon(Icons.directions),
onPressed: () {
Navigator.of(context).push(MaterialPageRoute(
builder: (context) =>
MyMap(snapshot.data!.docs[index].id)));
},
),
);
});


},
)),*/
