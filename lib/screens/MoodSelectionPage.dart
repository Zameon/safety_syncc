import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Selector',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MoodSelectionPage(),
      routes: {
        '/happy': (context) => MoodPage(mood: 'Happy'),
        '/sad': (context) => MoodPage(mood: 'Sad'),
        '/fear': (context) => MoodPage(mood: 'Fear'),
        '/anger': (context) => MoodPage(mood: 'Anger'),
        '/disgust': (context) => MoodPage(mood: 'Disgust'),
        '/surprise': (context) => MoodPage(mood: 'Surprise'),
      },
    );
  }
}

class MoodSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Selector'),
      ),
      body: BackgroundImage(
        imageAsset:
        'https://static.vecteezy.com/system/resources/previews/023/810/461/non_2x/minimalist-background-purple-abstract-design-free-vector.jpg',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'How was your mood today?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            MoodButtonsRow([
              MoodButton(mood: 'Happy', imageAsset: 'https://static.vecteezy.com/system/resources/thumbnails/000/374/945/small/4.jpg', route: '/happy'),
              MoodButton(mood: 'Sad', imageAsset: 'https://static.vecteezy.com/system/resources/previews/009/472/014/non_2x/cute-cat-sad-cartoon-illustration-vector.jpg', route: '/sad'),
              MoodButton(mood: 'Fear', imageAsset: 'https://static.vecteezy.com/system/resources/previews/016/545/693/original/feeling-inner-fears-and-panic-concept-fear-insecurities-haunting-you-young-stressed-frustrated-man-cartoon-character-scared-from-huge-shadow-vector.jpg', route: '/fear'),
            ]),
            SizedBox(height: 20),
            MoodButtonsRow([
              MoodButton(mood: 'Anger', imageAsset: 'https://static.vecteezy.com/system/resources/previews/005/836/463/non_2x/angry-panda-cartoon-illustration-posing-isolated-free-vector.jpg', route: '/anger'),
              MoodButton(mood: 'Disgust', imageAsset: 'https://static.vecteezy.com/system/resources/thumbnails/012/405/484/small/cartoon-disgusted-dog-free-vector.jpg', route: '/disgust'),
              MoodButton(mood: 'Surprise', imageAsset: 'https://static.vecteezy.com/system/resources/previews/020/198/195/non_2x/girl-holding-flower-surprised-face-cartoon-cute-vector.jpg', route: '/surprise'),
            ]),
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

class MoodButtonsRow extends StatelessWidget {
  final List<Widget> children;

  MoodButtonsRow(this.children);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}

class MoodButton extends StatelessWidget {
  final String mood;
  final String imageAsset;
  final String route;

  MoodButton({
    required this.mood,
    required this.imageAsset,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageAsset,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(
              mood,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodPage extends StatelessWidget {
  final String mood;

  MoodPage({required this.mood});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood: $mood'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'You selected $mood mood!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

