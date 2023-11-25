import 'package:flutter/material.dart';

class ChildsPoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Childs Pose'),
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
                        image: AssetImage('images/childs.gif'), // Update with your actual local image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(height: 20), // Add a space for text alignment
                  ),
                  Text(
                    'Childs Pose (Balasan)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Childs pose is a yoga pose that stretches the back, hips, thighs, and ankles. It can also help relieve stress and fatigue:',
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
                        bulletPoint('Kneel on the floor or a yoga mat.'),
                        bulletPoint('Touch your big toes together.'),
                        bulletPoint('Sit back on your heels.'),
                        bulletPoint('Separate your knees about as wide as your hips.'),
                        bulletPoint('Bend forward until your stomach touches your thighs.'),
                        bulletPoint('Rest your forehead on the floor.'),
                        bulletPoint('Extend your arms alongside your torso.'),
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
