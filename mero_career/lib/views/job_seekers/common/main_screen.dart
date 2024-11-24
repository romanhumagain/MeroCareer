import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_screen.dart';
import 'package:mero_career/views/job_seekers/mock_interview/screen/mock_interview_prep.dart';
import 'package:mero_career/views/job_seekers/search/screen/search_screen.dart';

import '../home/screen/home_screen.dart';
import '../menu/bottom_sheet_menu.dart';
import '../profile/screen/profile_screen.dart'; // Import ProfileScreen

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ChatScreen(),
    const MockInterviewPrep(),
    Container(), // Placeholder for the menu
    const ProfileScreen() // Add ProfileScreen to the list
  ];

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => const BottomSheetMenu(),
    );
  }

  void _navigateToProfile() {
    setState(() {
      _selectedIndex = 5; // Set index to ProfileScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: 80,
        leadingWidth: 350,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                height: 40,
              ),
              const SizedBox(width: 3),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "MeroCareer",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "Your Career, Your Path",
                    style: TextStyle(color: Colors.grey, fontSize: 9.5),
                  )
                ],
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: _navigateToProfile,
              child: const CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage(
                  'assets/images/pp.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex > 4 ? 0 : _selectedIndex,
            // Handle ProfileScreen
            onTap: (index) {
              if (index == 4) {
                _showMenu(context);
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                fontSize: 14.5),
            selectedFontSize: 14,
            selectedIconTheme: const IconThemeData(size: 24),
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
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.menu_outlined,
                    size: 28,
                  ),
                ),
                label: "Menu",
              )
            ],
          ),
        ),
      ),
    );
  }
}
