import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.dashboard,
                color: Colors.blueAccent,
              ),
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminHomeScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              title: const Text(
                'Manage Users',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageUsersPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.work,
                color: Colors.blueAccent,
              ),
              title: const Text(
                'Job Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JobPostsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.analytics,
                color: Colors.blueAccent,
              ),
              title: const Text(
                'Analytics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnalyticsPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                // Perform logout logic
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Admin Home Screen'),
      ),
    );
  }
}

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
      ),
      body: const Center(
        child: Text('Manage Users Page Content'),
      ),
    );
  }
}

class JobPostsPage extends StatelessWidget {
  const JobPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Posts'),
      ),
      body: const Center(
        child: Text('Job Posts Page Content'),
      ),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: const Center(
        child: Text('Analytics Page Content'),
      ),
    );
  }
}
