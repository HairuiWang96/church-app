import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: false,
            onChanged: (v) {
              // TODO: Implement theme switching
            },
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: true,
            onChanged: (v) {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
    );
  }
}
