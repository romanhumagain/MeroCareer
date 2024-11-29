import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/menu/screen/change_password_screen.dart';
import 'package:mero_career/views/job_seekers/menu/screen/deactivate_account.dart';

import '../../common/app_bar.dart';

class AccountSecurityManagement extends StatelessWidget {
  const AccountSecurityManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Security Management",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 20.5),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Manage your account by updating your email and password for enhanced protection",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()));
                    },
                    child: ListTile(
                      leading: Icon(Icons.lock_person_outlined),
                      title: Text(
                        "Change Account Password",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeactivateAccount()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                        size: 28,
                      ),
                      title: Text(
                        "Deactivate your account?",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
