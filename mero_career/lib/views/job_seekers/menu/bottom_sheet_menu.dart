import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/views/job_seekers/menu/screen/account_security_management.dart';
import 'package:mero_career/views/job_seekers/menu/screen/contact_us.dart';
import 'package:mero_career/views/job_seekers/menu/screen/settings_page.dart';
import 'package:mero_career/views/shared/login/login_page.dart';
import 'package:mero_career/views/widgets/custom_confirmation_message.dart';
import 'package:provider/provider.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    void handleUserLogout() async {
      AuthServices authServices = AuthServices();
      bool isConfirmed = await showCustomConfirmationDialog(
          context, "Are you sure you want to logout ?");

      if (isConfirmed) {
        await authServices.logoutUser();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }

    final TextStyle style1 = TextStyle(color: Colors.grey.shade600);
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    return Container(
      height: MediaQuery.of(context).size.height / 1.4,
      decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(28), topLeft: Radius.circular(28))),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 3.5,
            margin: const EdgeInsets.only(bottom: 15, top: 2),
            decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey,
                // Color of the small bar
                borderRadius: BorderRadius.circular(16)),
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
                  "Job Info",
                  style: style1,
                ),
                SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      leading: Icon(
                        Icons.bookmark,
                        color: Colors.blue,
                      ),
                      title: Text("Saved Jobs"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      leading: Icon(
                        Icons.app_registration_outlined,
                        color: Colors.blue,
                      ),
                      title: Text("Applied Jobs"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                Text(
                  "Account Settings",
                  style: style1,
                ),
                SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountSecurityManagement()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      leading: Icon(Icons.lock_person_outlined),
                      title: Text("Manage Account Security"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                Text(
                  "Insights",
                  style: style1,
                ),
                SizedBox(
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ContactUs()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      title: Text("Contact US"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    leading: Icon(
                      Icons.logout,
                    ),
                    title: const Text("Logout"),
                    onTap: () {
                      handleUserLogout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
