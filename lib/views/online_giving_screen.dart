import 'package:flutter/material.dart';

class OnlineGivingScreen extends StatelessWidget {
  const OnlineGivingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Online Giving')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.volunteer_activism,
                size: 64, color: Color(0xFF4A7C59)),
            const SizedBox(height: 16),
            const Text('Support our church online!'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Launch giving page
              },
              child: const Text('Give Now'),
            ),
          ],
        ),
      ),
    );
  }
}
