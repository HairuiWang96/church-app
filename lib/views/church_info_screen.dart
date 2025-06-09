import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChurchInfoScreen extends StatelessWidget {
  const ChurchInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Church Info')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/FBC-color-horizontal.png',
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text('3091 Advent Court, Lake Charles, LA 70607'),
            const SizedBox(height: 8),
            Text('Sunday Service: 10:30 AM'),
            Text('Wednesday Service: 5:30 PM'),
            const SizedBox(height: 16),
            Text('Contact: (337) 433-1443'),
            Text('Email: FBCLakeCharles@yahoo.com'),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.map),
                  onPressed: () {
                    // TODO: Open map
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {
                    // TODO: Open Facebook
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () {
                    // TODO: Open website
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
