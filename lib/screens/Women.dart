import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Women extends StatefulWidget {
  String Title;

  Women({required this.Title});

  @override
  State<Women> createState() => _WomenState();
}

class _WomenState extends State<Women> {
  Future<void> _launchURL(final link) async {
    launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication
    );
  }

  List<String> images=[
    "woman1",
    "woman2",
    "woman3",
    "woman4",
    "woman5"
  ];
  List<String> links=[
    "https://www.youtube.com/watch?v=k9Jn0eP-ZVg",
    "https://www.healthline.com/health/womens-health/self-defense-tips-escape",
    "https://brightside.me/articles/7-self-defense-techniques-for-women-recommended-by-a-professional-441310/",
    "https://www.tbsnews.net/bangladesh/8-techniques-every-woman-should-know-self-defense-141475#tbl-em-lnn7xe5u050l5tjlig5c",
    "https://www.prevention.com/fitness/g20499844/self-defense-moves-for-women/",
  ];

  int i=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          centerTitle: true,
          title: Text(
            widget.Title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Scrollbar(
          thumbVisibility: true,
          child: ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) => _buildButton(images[index], links[index]),
              separatorBuilder: (context,index) => SizedBox(height: 5,),
              itemCount: images.length),

        )
    );
  }

  Widget _buildButton(String image, String link){
    return Card(
      margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
      color: Colors.purple[100],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: TextButton(
                onPressed: () {
                  _launchURL(link);
                },
                child: Image.asset(
                  'images/$image.png',
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
