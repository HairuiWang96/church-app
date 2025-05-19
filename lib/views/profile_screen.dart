import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 48)),
            const SizedBox(height: 16),
            Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('john.doe@email.com'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
