import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_provider.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/job_seekers/notification/widgets/notification_tile.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class RecruiterNotificationScreen extends StatefulWidget {
  const RecruiterNotificationScreen({super.key});

  @override
  State<RecruiterNotificationScreen> createState() =>
      _RecruiterNotificationScreenState();
}

class _RecruiterNotificationScreenState
    extends State<RecruiterNotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotification();
  }

  void fetchNotification() async {
    await Provider.of<JobSeekerProvider>(context, listen: false)
        .fetchNotifications();
    await Future.delayed(Duration(seconds: 1));
    await Provider.of<JobSeekerProvider>(context, listen: false)
        .markAllNotificationRead();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notifications",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 20, letterSpacing: 0.4),
              ),
              SizedBox(
                height: 10,
              ),
              MyDivider(),
              SizedBox(
                height: 10,
              ),
              Consumer<JobSeekerProvider>(builder: (context, provider, child) {
                final notificationData = provider.notificationDetails;
                if (notificationData!.isEmpty) {
                  return Text(
                    "No recent notification found !",
                    style: TextStyle(fontSize: 16),
                  );
                }
                return Column(
                  children: [
                    notificationData['new'].isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "New",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  )
                                ],
                              ),
                              Column(
                                children: notificationData['new']
                                    .map<Widget>((notification) {
                                  return NotificationTile(
                                    notification: notification,
                                  );
                                }).toList(),
                              )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    notificationData['new'].length > 0
                        ? MyDivider()
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    notificationData['last_7_days'].isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Last 7 days",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  )
                                ],
                              ),
                              Column(
                                children: notificationData['last_7_days']
                                    .map<Widget>((notification) {
                                  return NotificationTile(
                                    notification: notification,
                                  );
                                }).toList(),
                              )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    MyDivider(),
                    SizedBox(
                      height: 10,
                    ),
                    notificationData['last_30_days'].isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Last 30 days",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  )
                                ],
                              ),
                              Column(
                                children: notificationData['last_30_days']
                                    .map<Widget>((notification) {
                                  return NotificationTile(
                                    notification: notification,
                                  );
                                }).toList(),
                              )
                            ],
                          )
                        : SizedBox(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
