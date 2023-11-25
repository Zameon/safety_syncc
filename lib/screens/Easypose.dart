import 'package:flutter/material.dart';

class EasyPoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Pose'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/007/118/669/small/abstract-gradient-purple-with-wavy-and-rounded-shape-illustration-free-vector.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/easy.gif'), // Update with your actual local image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(height: 20), // Add a space for text alignment
                  ),
                  Text(
                    'Easy Pose (Sukhasana)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Easy Pose (Sukhasana ) is the name for any comfortable, cross-legged, seated position, and one of the most basic poses used in yoga practice and meditation:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 150,
                    // Fixed height for the bullet points
                    child: ListView(
                      children: [
                        bulletPoint('Sit on a yoga mat with your legs extended outward.'),
                        bulletPoint('Position your arms and shoulders.'),
                        bulletPoint('Cross your legs.'),
                        bulletPoint('Widen your knees.Relax your arms.'),
                        bulletPoint('Straighten your back.'),
                        bulletPoint('Soften the neck and gaze ahead. '),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Row(
      children: [
        Icon(
          Icons.fiber_manual_record,
          size: 12,
          color: Colors.white,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
