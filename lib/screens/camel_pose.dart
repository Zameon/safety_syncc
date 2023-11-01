import 'package:flutter/material.dart';

class CamelPoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camel Pose'),
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
                        image: NetworkImage('https://media.istockphoto.com/id/1262414064/photo/diverse-young-sporty-people-practicing-flexibility-in-camel-pose.jpg?s=612x612&w=0&k=20&c=d_iFTx6RxWDOpBaZmbI0rOz2E7frXVUwrx-wEWLWFNk='),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(height: 20), // Add a space for text alignment
                  ),
                  Text(
                    'Camel Pose (Ustrasana)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The Camel Pose, also known as Ustrasana, is a yoga posture that provides various physical and mental benefits. Here are some key points about this pose:',
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
                        bulletPoint('Kneel on the floor with your legs hip-width apart.'),
                        bulletPoint('Lean backward and reach your heels with your hands.'),
                        bulletPoint('Open up your chest and bend your spine.'),
                        bulletPoint('Stretches the front of the body.'),
                        bulletPoint('Improves posture and back flexibility.'),
                        bulletPoint('Relieves stress and anxiety.'),
                        bulletPoint('It\'s a great pose for heart opening.'),
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
