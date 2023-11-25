import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/plankpose.dart';

import 'Treepose.dart';
import 'butterfly_pose.dart';
import 'camel_pose.dart';
import 'love.dart';

void main() {
  runApp(MaterialApp(
    home: FearMoodPage(),
  ));
}

class FearMoodPage extends StatelessWidget {
  final Map<String, String> buttonData = {
    'Worried': 'https://static.vecteezy.com/system/resources/previews/018/980/493/non_2x/worried-man-illustration-vector.jpg',
    'Doubtful': 'https://static.vecteezy.com/system/resources/previews/021/970/639/non_2x/confused-uncertain-feeling-in-doubtful-decision-worry-and-think-with-serious-thoughtful-expression-question-mark-dilemma-undecided-concept-illustration-free-vector.jpg',
    'Nervous': 'https://static.vecteezy.com/system/resources/thumbnails/006/388/994/small/awkward-moment-embarrassment-conversation-nervous-and-clueless-at-work-dull-moment-or-cannot-answer-question-concept-awkward-confused-and-shrug-businessman-with-helpless-speech-bubble-vector.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fear Mood'),
        backgroundColor: Colors.purple,
      ),
      body: BackgroundImage(
        imageAsset:
        'https://static.vecteezy.com/system/resources/previews/023/810/461/non_2x/minimalist-background-purple-abstract-design-free-vector.jpg',
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              height: 200.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meditate',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'To know yourself is to be confident.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.network(
                      'https://static.vecteezy.com/system/resources/thumbnails/004/261/144/small/woman-meditating-in-nature-and-leaves-concept-illustration-for-yoga-meditation-relax-recreation-healthy-lifestyle-illustration-in-flat-cartoon-style-free-vector.jpg',
                      width: 200.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Meditation Music',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SlidingButton(
                      text: 'Worried',
                      imageUrl: buttonData['Worried']!,
                    ),
                    SlidingButton(
                      text: 'Doubtful',
                      imageUrl: buttonData['Doubtful']!,
                    ),
                    SlidingButton(
                      text: 'Nervous',
                      imageUrl: buttonData['Nervous']!,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Meditation Poses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WhiteButtonWithImage(
                      text: 'Tree Pose',
                      imageUrl:
                      'https://static.vecteezy.com/system/resources/thumbnails/005/477/896/small/woman-doing-tree-pose-vrksasana-exercise-flat-illustration-isolated-on-white-background-free-vector.jpg',
                    ),
                    SizedBox(width: 30),
                    WhiteButtonWithImage(
                      text: 'Plank Pose',
                      imageUrl:
                      'https://static.vecteezy.com/system/resources/previews/006/417/766/non_2x/woman-doing-plank-pose-phalakasana-exercise-flat-illustration-isolated-on-white-background-free-vector.jpg',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SlidingButton extends StatefulWidget {
  final String text;
  final String imageUrl;

  SlidingButton({
    required this.text,
    required this.imageUrl,
  });

  @override
  _SlidingButtonState createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton> {
  Color buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          if (widget.text == 'Worried') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MusicPlayer()), // Navigate to the Love screen
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.imageUrl,
              width: 150.0,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              widget.text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteButtonWithImage extends StatefulWidget {
  final String text;
  final String imageUrl;

  WhiteButtonWithImage({
    required this.text,
    required this.imageUrl,
  });

  @override
  _WhiteButtonWithImageState createState() => _WhiteButtonWithImageState();
}

class _WhiteButtonWithImageState extends State<WhiteButtonWithImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          // Add your action here
          if (widget.text == 'Tree Pose') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TreePoseScreen()),
            );
          }
          if (widget.text == 'Plank Pose') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlankPoseScreen()),
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.imageUrl,
              width: 110.0,
              height: 90.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              widget.text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String imageAsset;
  final Widget child;

  BackgroundImage({required this.imageAsset, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.1),
        BlendMode.srcOver,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
