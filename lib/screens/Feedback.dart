import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController = TextEditingController();
  double rating = 0.0;
  String? name;
  final usr = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserData');

  submitFeedback() async{
    await getUsersData();
    // Handle the feedback submission here.
    // You can send the feedback and rating to your backend or handle it locally.
    // After submission, navigate to the confirmation page.

    final CollectionReference feedbackCollection =
    FirebaseFirestore.instance.collection('FeedBack'); // Replace 'feedback' with your Firestore collection name

    try {
      await feedbackCollection.add({
        'comment': feedbackController.text,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
        'username': name,
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(),
        ),
      );
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
      print('Error submitting feedback: $e');
    }

    feedbackController.clear();
    setState(() {
      rating = 0;  // Or whatever your initial rating value is
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(
          child: Text(
            'Feedback',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(labelText: 'Feedback Comment'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Center(child: Text('Rate your experience:')),
            Center(
              child: RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitFeedback,
                child: Text(
                    'Submit Feedback',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple[200],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                )
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'Reviews',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('FeedBack').snapshots(),
                builder: (context, snapshot) {
                  List<Row> clientWidgets = [];
                  if(snapshot.hasData)
                  {
                    final clients = snapshot.data?.docs.reversed.toList();

                    for(var client in clients!)
                    {
                      final clientWidget = Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:100,
                              child: Text(client['username'])
                          ),
                          Container(
                            width: 150,  // Specify your desired width
                            child: Flexible(
                              child: Text(
                                client['comment'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Container(
                            width:30,
                              child: Text(client['rating'].toString())),
                         // Text(client['timestamp'].toString()),
                        ],
                      );
                      clientWidgets.add(clientWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: clientWidgets,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  );
                }
            ),
            Image(image: AssetImage("images/feedbackgif.gif")),
          ],
        ),
    );
  }

  getUsersData() async {
    await collectionReference.doc(usr!.uid).get().then((value) {
      setState(() {
        name =  value['username'];
      });
    });
    print(name);
  }
}

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(
          child: Text(
            'Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            Text(
              'Thank you for your feedback!',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}