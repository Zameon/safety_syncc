import 'package:flutter/material.dart';

import 'butterfly_pose.dart';
import 'camel_pose.dart';
import 'love.dart';

void main() {
  runApp(MaterialApp(
    home: HappyMoodPage(),
  ));
}

class HappyMoodPage extends StatelessWidget {
  final Map<String, String> buttonData = {
    'Love': 'https://static.vecteezy.com/system/resources/previews/005/426/657/non_2x/cute-panda-couple-love-cartoon-icon-illustration-animal-icon-concept-isolated-premium-flat-cartoon-style-vector.jpg',
    'Peace': 'https://static.vecteezy.com/system/resources/previews/003/820/044/original/cute-dove-flying-free-vector.jpg',
    'Hope': 'https://static.vecteezy.com/system/resources/previews/029/569/503/non_2x/hope-lettering-poster-no-war-sign-floral-and-flower-ornamental-decorations-hand-drawn-illustration-organic-drawings-support-ukraine-vintage-style-vector.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Mood'),
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
                      text: 'Love',
                      imageUrl: buttonData['Love']!,
                    ),
                    SlidingButton(
                      text: 'Peace',
                      imageUrl: buttonData['Peace']!,
                    ),
                    SlidingButton(
                      text: 'Hope',
                      imageUrl: buttonData['Hope']!,
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
                      text: 'Camel Pose',
                      imageUrl:
                      'https://static.vecteezy.com/system/resources/previews/005/178/403/non_2x/woman-doing-camel-pose-or-ustrasana-exercise-free-vector.jpg',
                    ),
                    SizedBox(width: 30),
                    WhiteButtonWithImage(
                      text: 'Butterfly Pose',
                      imageUrl:
                      'https://static.vecteezy.com/system/resources/previews/015/708/606/non_2x/woman-doing-seated-butterfly-pose-beautiful-girl-practice-baddha-upavistha-titli-asana-flat-illustration-isolated-on-white-background-vector.jpg',
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
          if (widget.text == 'Love') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MusicPlayer()), // Navigate to the Love screen
            );
          }
          if (widget.text == 'Peace') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MusicPlayer()), // Navigate to the Love screen
            );
          }
          if (widget.text == 'Hope') {
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
          if (widget.text == 'Butterfly Pose') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ButterflyPoseScreen()),
            );
          }
          if (widget.text == 'Camel Pose') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CamelPoseScreen()),
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
