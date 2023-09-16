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

class _LocationScreenState extends State<LocationScreen> {
  final loc.Location location = loc.Location();
  late String? lat;
  late String? long;
  late String? name;
  StreamSubscription<loc.LocationData>? _locationSubscription;
  final usr = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserData');

  @override
  void initState() {
    super.initState();
    _requestPermission();
    // location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    // location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
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
          )),
        ],
      ),
    );
  }

  _getLocation() async {
    getUsersData();
    print(name);
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

  void getUsersData() {
    collectionReference.doc(usr!.uid).get().then((value) {
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
