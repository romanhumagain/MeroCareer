import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/chat_provider.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_screen.dart';
import 'package:mero_career/views/job_seekers/search/screen/search_screen.dart';
import 'package:provider/provider.dart';

import '../home/screen/home_screen.dart';
import '../menu/bottom_sheet_menu.dart';
import '../notification/screen/notification_screen.dart';
import '../profile/screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final bool isLoggedInNow;

  const MainScreen({super.key, this.isLoggedInNow = false});

  @override
  State<MainScreen> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ChatScreen(),
    NotificationScreen(),
    Container(),
    const ProfileScreen()
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
      _selectedIndex = 5;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchJobSeekeProfileDetails();
    });
  }

  void _fetchJobSeekeProfileDetails() async {
    if (!widget.isLoggedInNow) {
      Provider.of<ProfileSetupProvider>(context, listen: false)
          .fetchJobSeekerProfileDetails();
    }
    await Provider.of<JobSeekerProvider>(context, listen: false)
        .getAllUnreadNotification();

    await Provider.of<ChatProvider>(context, listen: false)
        .getUnreadMessageCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: 70,
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
          Consumer<ProfileSetupProvider>(builder: (context, provider, child) {
            final jobSeekerDetails = provider.jobSeekerProfileDetails;
            return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                  onTap: _navigateToProfile,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: jobSeekerDetails?['profile_image'] != null
                        ? NetworkImage(jobSeekerDetails?['profile_image'])
                        : AssetImage('assets/images/blank_pp.png')
                            as ImageProvider, // Cast AssetImage to ImageProvider
                  )),
            );
          }),
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
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(size: 25, Icons.home),
                ),
                label: "Home",
              ),
              const BottomNavigationBarItem(
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
                  child: Consumer<ChatProvider>(
                      builder: (context, provider, child) {
                    final int unreadMessage = provider.unreadMessageCount;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          _selectedIndex != 2
                              ? CupertinoIcons.chat_bubble
                              : CupertinoIcons.chat_bubble_fill,
                          size: 24.5,
                        ),
                        if (unreadMessage > 0)
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                unreadMessage.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Consumer<JobSeekerProvider>(
                      builder: (context, provider, child) {
                    final int unreadMessage =
                        provider.unreadNotification!.length;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          _selectedIndex != 3
                              ? CupertinoIcons.bell
                              : CupertinoIcons.bell_fill,
                          size: 24.5,
                        ),
                        if (unreadMessage > 0)
                          Positioned(
                            right: -6, // Adjust position as per your design
                            top: -6,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                unreadMessage.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
                label: "Notification",
              ),
              const BottomNavigationBarItem(
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
