import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  String Title;

  AboutUsPage({required this.Title});
  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(
          child: Text(
            'About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Introduction
            Text(
              'Welcome to Safety Sync - Your Safety and Well-being Companion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'At Safety Sync, our mission is to empower you with tools and knowledge to enhance your safety, well-being, and overall quality of life. We are committed to providing you with the support and resources you need to thrive in a sometimes uncertain world.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Mission and Vision
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'To create a safer and more secure world by equipping individuals with the skills, knowledge, and technology they need to protect themselves and their loved ones.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'To build a global community where safety, self-improvement, and mental well-being are accessible to all, leading to a brighter and more confident future for every user.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Team Introduction
            Text(
              'Meet Our Team',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Replace the placeholders with your team members' details
            TeamMemberCard(
              name: 'Ramisa Zaman Audhi',
              role: 'Developer',
              image: 'images/person3.png', // Path to the team member's image
            ),
            TeamMemberCard(
              name: 'Sadia Sultana',
              role: 'Developer',
              image: 'images/person2.png', // Path to the team member's image
            ),
            TeamMemberCard(
              name: 'Saiyma Sittul Muna',
              role: 'Developer',
              image: 'images/person1.png', // Path to the team member's image
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;

  TeamMemberCard({required this.name, required this.role, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
          ListTile(
            title: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(role),
          ),
        ],
      ),
    );
  }
}
