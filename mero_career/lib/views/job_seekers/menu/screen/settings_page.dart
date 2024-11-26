import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage Job Alerts",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 20.8, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "There are notification that newly posted jobs match with your profile",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Jobs Alert",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.6,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                        child: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: true,
                            onChanged: (value) {}),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job Recommendation",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.6,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                        child: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: true,
                            onChanged: (value) {}),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job Application Updates",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.6,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                        child: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: true,
                            onChanged: (value) {}),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
