import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_screen.dart';
import 'package:mero_career/views/job_seekers/mock_interview/screen/mock_interview_prep.dart';
import 'package:mero_career/views/job_seekers/profile/screen/profile_screen.dart';
import 'package:mero_career/views/job_seekers/search/screen/search_screen.dart';

import '../home/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<MainScreen> {
  // List of screens for navigation
  final List<Widget> _screens = [
    // const JobDetailsScreen(),
    const HomeScreen(),
    const SearchScreen(),
    const ChatScreen(),
    const MockInterviewPrep(),
    const ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                fontSize: 14.5),
            selectedFontSize: 14,
            selectedIconTheme: IconThemeData(size: 24),
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.home_filled),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 24.5,
                  ),
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    CupertinoIcons.chat_bubble_fill,
                    size: 23,
                  ),
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.dashboard,
                    size: 24.5,
                  ),
                ),
                label: "Interview",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(
                      'assets/images/pp.jpg',
                    ),
                  ),
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
