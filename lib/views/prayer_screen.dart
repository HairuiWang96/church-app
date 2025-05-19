import 'package:flutter/material.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _requestController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final List<Map<String, String>> _prayerRequests = [
    {
      'name': 'Anonymous',
      'request': 'Please pray for my family during this difficult time.'
    },
    {'name': 'Sarah', 'request': 'Pray for my upcoming job interview.'},
    {'name': 'John', 'request': 'Healing for a friend in the hospital.'},
  ];

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _prayerRequests.insert(0, {
          'name':
              _nameController.text.isEmpty ? 'Anonymous' : _nameController.text,
          'request': _requestController.text,
        });
        _nameController.clear();
        _requestController.clear();
        _contactController.clear();
      });
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prayer request submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Prayer Requests',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submit a Prayer Request',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Let us pray for you. Fill out the form below and our prayer team will lift your request up.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Your Name (optional)',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _requestController,
                            decoration: const InputDecoration(
                              labelText: 'Prayer Request',
                              prefixIcon: Icon(Icons.favorite_border),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your prayer request.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _contactController,
                            decoration: const InputDecoration(
                              labelText: 'Contact Info (optional)',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _submitRequest,
                              icon: const Icon(Icons.send),
                              label: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Recent Prayer Requests',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _prayerRequests.length) return null;
                final request = _prayerRequests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.15),
                      child:
                          const Icon(Icons.favorite, color: Colors.redAccent),
                    ),
                    title: Text(request['name'] ?? 'Anonymous',
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(request['request'] ?? ''),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _requestController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}
