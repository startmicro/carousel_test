import 'package:flutter/material.dart';

class OpponentView extends StatelessWidget {
  final Map<String, Object> profile;

  const OpponentView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Opponent View')),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png", // Path to the image
            fit: BoxFit.cover, // Adjust the image to cover the screen
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Opponent: ${profile['name']}'),
                // Hier kannst du weitere Informationen über den Gegner anzeigen
              ],
            ),
          ),
        ],
      ),
    );
  }
}
