import 'package:flutter/material.dart';

class PlankPoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plank Pose'),
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
                        image: AssetImage('images/plank.gif'), // Update with your actual local image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(height: 20), // Add a space for text alignment
                  ),
                  Text(
                    'Plank Pose (Baddha Konasana)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The Butterfly Pose, also known as Baddha Konasana, is a yoga posture that provides various physical and mental benefits. Here are some key points about this pose:',
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
                        bulletPoint('Sit with your legs bent at the knees and your feet.'),
                        bulletPoint('Hold your feet with your hands.'),
                        bulletPoint('Improves flexibility in the inner thighs and groins.'),
                        bulletPoint('Stimulates the abdominal organs and helps digestion.'),
                        bulletPoint('Calms the mind and reduces stress and fatigue.'),
                        bulletPoint('Enhances blood circulation in the pelvis.'),
                        bulletPoint('It\'s a great pose for meditation and relaxation.'),
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
