import 'package:flutter/material.dart';

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
      ),
      body: BackgroundImage(
        imageAsset:
        'https://static.vecteezy.com/system/resources/previews/023/810/461/non_2x/minimalist-background-purple-abstract-design-free-vector.jpg',
        child: Column(
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
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: buttonData.entries.map((entry) {
                      return SlidingButton(
                        text: entry.key,
                        imageUrl: entry.value,
                      );
                    }).toList(),
                  ),
                ),
              ),
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
  Color? buttonColor = Colors.white70;

  void changeButtonColor() {
    setState(() {
      buttonColor = Colors.purple; // Change the color to blue when pressed.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: InkResponse(
        onTap: changeButtonColor,
        child: ElevatedButton(
          onPressed: () {
            // Add your action here
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                widget.imageUrl,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                widget.text,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
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
