import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_screen.dart';
import 'package:mero_career/views/recruiters/applicants/screen/view_applicants_screen.dart';
import 'package:mero_career/views/recruiters/home/screen/home_screen.dart';
import 'package:mero_career/views/recruiters/job_post/screen/job_post_screen.dart';
import 'package:mero_career/views/recruiters/job_post/screen/recruiter_job_post_screen.dart';
import 'package:mero_career/views/recruiters/menu/screen/recruiter_bottom_sheet_menu.dart';

import '../profile/screen/profile_screen.dart';

class RecruiterMainScreen extends StatefulWidget {
  const RecruiterMainScreen({super.key});

  @override
  State<RecruiterMainScreen> createState() => _RecruiterMainScreenState();
}

class _RecruiterMainScreenState extends State<RecruiterMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ViewApplicantsScreen(),
    RecruiterJobPostScreen(),
    ChatScreen(),
    JobPostScreen(),
    RecruiterProfileScreen(),
  ];

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => const RecruiterBottomSheetMenu(),
    );
  }

  void _navigateToProfile() {
    setState(() {
      _selectedIndex = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: 60,
        leadingWidth: 350,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: Padding(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: _navigateToProfile,
              child: const CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage(
                  'assets/images/company_logo/f1.jpg',
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
                    Icons.app_registration,
                    size: 28.5,
                  ),
                ),
                label: "Applicants",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    CupertinoIcons.add_circled,
                    size: 28,
                  ),
                ),
                label: "Post Job",
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
