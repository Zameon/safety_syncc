import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Adult extends StatefulWidget {
  String Title;

  Adult({required this.Title});

  @override
  State<Adult> createState() => _AdultState();
}

class _AdultState extends State<Adult> {

  Future<void> _launchURL(final link) async {
    launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication
    );
  }

  List<String> images=[
    "adult1",
    "adult2",
    "adult3",
    "adult4",
    "adult5"
  ];
  List<String> links=[
    "https://premiermartialarts.com/adult-martial-arts/",
    "https://www.youtube.com/watch?v=ERMZRMqQmVI",
    "https://www.youtube.com/watch?v=T7aNSRoDCmg",
    "https://www.realsimple.com/health/preventative-health/safety/4-essential-self-defense-moves-everyone-should-know",
    "https://blog.joinfightcamp.com/training/self-defense-5-effective-moves-for-beginners/",
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
