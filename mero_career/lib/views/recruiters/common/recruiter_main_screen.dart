import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/recruiter_provider.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_screen.dart';
import 'package:mero_career/views/recruiters/applicants/screen/view_applicants_screen.dart';
import 'package:mero_career/views/recruiters/home/screen/home_screen.dart';
import 'package:mero_career/views/recruiters/job_post/screen/recruiter_job_post_screen.dart';
import 'package:mero_career/views/recruiters/menu/screen/recruiter_bottom_sheet_menu.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat_provider.dart';
import '../profile/screen/profile_screen.dart';

class RecruiterMainScreen extends StatefulWidget {
  final bool? isLoggedInNow;

  const RecruiterMainScreen({super.key, this.isLoggedInNow = false});

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
      _selectedIndex = 4;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchRecruiterProfileDetails();
    });
  }

  void _fetchRecruiterProfileDetails() async {
    if (!widget.isLoggedInNow!) {
      Provider.of<RecruiterProvider>(context, listen: false)
          .fetchRecruiterProfile();
    }

    await Provider.of<ChatProvider>(context, listen: false)
        .getUnreadMessageCount();
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
          Consumer<RecruiterProvider>(builder: (context, provider, child) {
            final recruiterDetails = provider.recruiterProfileDetails;
            return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                  onTap: _navigateToProfile,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundImage: recruiterDetails?[
                                'company_profile_image'] !=
                            null
                        ? NetworkImage(
                            recruiterDetails?['company_profile_image'])
                        : const AssetImage(
                                'assets/images/company_logo/default_company_pic.png')
                            as ImageProvider,
                  )),
            );
          })
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
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.home_filled),
                ),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.app_registration,
                    size: 28.5,
                  ),
                ),
                label: "Applicants",
              ),
              const BottomNavigationBarItem(
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
                  padding: const EdgeInsets.all(4),
                  child: Consumer<ChatProvider>(
                      builder: (context, provider, child) {
                    final int unreadMessage = provider.unreadMessageCount;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          _selectedIndex != 3
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
