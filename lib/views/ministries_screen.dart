import 'package:flutter/material.dart';

class MinistriesScreen extends StatelessWidget {
  const MinistriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ministries = [
      {
        'icon': Icons.child_care,
        'name': 'Children',
        'desc': 'Fun and faith for kids.'
      },
      {
        'icon': Icons.emoji_people,
        'name': 'Youth',
        'desc': 'Teens growing in Christ.'
      },
      {
        'icon': Icons.music_note,
        'name': 'Music',
        'desc': 'Choir, band, and worship.'
      },
      {
        'icon': Icons.volunteer_activism,
        'name': 'Outreach',
        'desc': 'Serving our community.'
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Ministries')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ministries.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            leading: Icon(ministries[i]['icon'] as IconData,
                color: Theme.of(context).colorScheme.primary),
            title: Text(ministries[i]['name'] as String),
            subtitle: Text(ministries[i]['desc'] as String),
          ),
        ),
      ),
    );
  }
}
