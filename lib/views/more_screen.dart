import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'sermons_screen.dart';
import 'events_screen.dart';
import 'prayer_screen.dart';
import 'profile_screen.dart';
import 'church_info_screen.dart';
import 'online_giving_screen.dart';
import 'ministries_screen.dart';
import 'settings_screen.dart';
import 'contact_us_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('More', style: theme.textTheme.titleLarge),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (authService.isAuthenticated && !authService.isGuest) ...[
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person_outline),
              ),
              title: Text(authService.fullName ?? 'User'),
              subtitle: Text(authService.userEmail ?? ''),
            ),
            const Divider(),
          ],
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.person, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Profile'),
              subtitle: const Text('View and edit your profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.info_outline, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Church Info'),
              subtitle: const Text('About, address, and contact'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChurchInfoScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.volunteer_activism,
                    color: Color(0xFF4A7C59)),
              ),
              title: const Text('Online Giving'),
              subtitle: const Text('Support the church online'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OnlineGivingScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.groups, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Ministries'),
              subtitle: const Text('Explore our ministries'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MinistriesScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.settings, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Settings'),
              subtitle: const Text('App preferences'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.mail_outline, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Contact Us'),
              subtitle: const Text('Get in touch with us'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                );
              },
            ),
          ),
          if (authService.isAuthenticated) ...[
            const Divider(),
            Card(
              color: Colors.red.shade50,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.shade100,
                  child: const Icon(Icons.logout, color: Colors.red),
                ),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Sign Out'),
                      content: const Text('Are you sure you want to sign out?'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Sign Out'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true && context.mounted) {
                    await authService.signOut();
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
