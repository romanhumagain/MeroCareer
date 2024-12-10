import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, bool> accountSettings = {};

  @override
  void initState() {
    super.initState();
    getAccountDetails();
  }

  void getAccountDetails() async {
    await Provider.of<JobSeekerProvider>(context, listen: false)
        .getAccountSettings();
    final provider = Provider.of<JobSeekerProvider>(context, listen: false);
    setState(() {
      accountSettings = {
        "new_job_alert": provider.accountSettings?['new_job_alert'],
        "job_application_status_alert":
            provider.accountSettings?['job_application_status_alert'],
        "job_recommendation_alert":
            provider.accountSettings?['job_recommendation_alert'],
      };
    });
  }

  void updateSetting(String key, bool value) {
    setState(() {
      accountSettings[key] = value;
    });

    Provider.of<JobSeekerProvider>(context, listen: false)
        .updateAccountSettings(accountSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: accountSettings.isEmpty
          ? Center(child: Text("No settings found for this account!"))
          : Padding(
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
                  SizedBox(height: 10),
                  Text(
                    "There are notifications that newly posted jobs match with your profile",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  if (accountSettings.isNotEmpty)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Last Updated: ${formatPostedDate(Provider.of<JobSeekerProvider>(context, listen: false).accountSettings?['updated_at'])}",
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Divider(
                      color: Theme.of(context).colorScheme.surfaceContainer),
                  SizedBox(height: 20),
                  buildSwitchRow(
                    context,
                    "New Jobs Alert",
                    "new_job_alert",
                  ),
                  SizedBox(height: 40),
                  buildSwitchRow(
                    context,
                    "Job Recommendation",
                    "job_recommendation_alert",
                  ),
                  SizedBox(height: 40),
                  buildSwitchRow(
                    context,
                    "Job Application Updates",
                    "job_application_status_alert",
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget buildSwitchRow(BuildContext context, String title, String settingKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.6,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        CupertinoSwitch(
          activeColor: Colors.blue,
          value: accountSettings[settingKey] ?? false,
          onChanged: (value) {
            updateSetting(settingKey, value);
          },
        ),
      ],
    );
  }
}
