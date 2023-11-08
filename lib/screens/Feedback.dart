import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(labelText: 'Feedback Comment'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Text('Rate your experience:'),
            RatingBar.builder(
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitFeedback,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
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
        title: Text('Feedback Confirmation'),
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
