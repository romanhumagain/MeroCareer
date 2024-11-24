import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle style1 = TextStyle(color: Colors.grey.shade600);
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(28), topLeft: Radius.circular(28))),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 4,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.grey, // Color of the small bar
              borderRadius: BorderRadius.circular(12), // Rounded edges
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Theme",
                  style: style1,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Dark Mode",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      CupertinoSwitch(
                          value: (isDarkMode),
                          onChanged: (value) {
                            context
                                .read<ThemeProvider>()
                                .updateTheme(value: value);
                          }),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                Text(
                  "Account Settings",
                  style: style1,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Update Profile"),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.lock_person_outlined),
                  title: Text("Manage Account Security"),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                Text(
                  "Insights",
                  style: style1,
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Contact US"),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    // Perform Logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
