import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedpreferences/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<UserSettingsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "User Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings saved successfully!')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
        buildProfileSection(settingsProvider),
          const Divider(height: 40),
          buildSettingsSection(context, settingsProvider),
          const Divider(height: 40),
          buildNotificationSection(settingsProvider),
        ],
      ),
    );
  }

  Widget buildProfileSection(UserSettingsProvider settingsProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
            ),
            onChanged: settingsProvider.setUsername,
            controller: TextEditingController(text: settingsProvider.username),
          ),
        ],
      ),
    );
  }

  Widget buildSettingsSection(BuildContext context, UserSettingsProvider settingsProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appearance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("Toggle dark theme"),
              secondary: Icon(
                settingsProvider.darkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              value: settingsProvider.darkMode,
              onChanged: settingsProvider.toggleDarkMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationSection(UserSettingsProvider settingsProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daily Notifications",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_off, color: Colors.red),
                        onPressed: () {
                          settingsProvider.updateNotificationCount(
                            settingsProvider.notificationCount > 0
                                ? settingsProvider.notificationCount - 1
                                : 0,
                          );
                        },
                      ),
                      Icon(
                        Icons.notifications,
                        size: 32,
                        color: settingsProvider.notificationCount > 0
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_active, color: Colors.green),
                        onPressed: () {
                          settingsProvider.updateNotificationCount(
                            settingsProvider.notificationCount + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
