
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfDefense extends StatefulWidget {

  String Title;

  SelfDefense({required this.Title});

  @override
  State<SelfDefense> createState() => _SelfDefenseState();
}

class _SelfDefenseState extends State<SelfDefense> {

  Future<void> _launchURL(final link) async {
    launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication
    );
  }

  List<String> images=[
    "kid1",
    "kid2",
    "kid3",
    "kid4",
    "kid5"
  ];
  List<String> links=[
    "https://thewayfamilydojo.com/why-kids-should-learn-self-defense/",
    "https://www.youtube.com/watch?v=WPkCbx-cgSM",
    "https://www.divasfordefense.com/blogs/self-defense-articles-5/11-self-defense-moves-to-teach-your-children",
    "https://www.thekoma.com/post/the-self-defense-your-child-needs-to-deal-with-bullying",
    "https://www.verywellfamily.com/how-kids-can-defend-themselves-against-bullies-460789",
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

/*

ElevatedButton(
        onPressed: (){
          const link = "https://www.youtube.com/watch?v=V80A8qN4fR8&list=RDMMV80A8qN4fR8&start_radio=1";
          launchUrl(
            Uri.parse(link),
            mode: LaunchMode.externalApplication
          );
        },
        child: Text('tap'),
      )
 */