import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavMenu extends StatefulWidget {
  const GoogleNavMenu({super.key});

  @override
  State<GoogleNavMenu> createState() => _MainScreenState();
}

class _MainScreenState extends State<GoogleNavMenu> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;

    return Container(
      color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GNav(
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: CupertinoIcons.chat_bubble_fill,
              text: "Chat",
            ),
            GButton(
              icon: Icons.dashboard,
              text: "Inteview",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
          backgroundColor:
              isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          activeColor: Theme.of(context).colorScheme.primary,
          color: Colors.grey,
          tabBackgroundColor:
              isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          padding: EdgeInsets.all(8.5),
          rippleColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
          // tab button hover color
          haptic: true,
          // haptic feedback
          tabActiveBorder: Border.all(
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
              width: 1),
          iconSize: 24,
          textStyle: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 0.4),
        ),
      ),
    );
  }
}
