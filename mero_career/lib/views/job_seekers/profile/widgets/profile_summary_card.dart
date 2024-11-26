import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddProfileSummarySection(context);
      },
      child: Container(
        width: widget.size.width / 1.15,
        height: widget.size.height / 8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile Summary",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 17.2),
                ),
                Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Highlight your key career achievements to help recruiters knows your potential",
              style: Theme.of(context).textTheme.titleSmall,
            )
          ]),
        ),
      ),
    );
  }

  void _showAddProfileSummarySection(BuildContext context) {
    TextEditingController profileSummaryController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return Container(
            height: widget.size.height / 1.15,
            width: widget.size.width,
            decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      ModalTopBar(),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Profile Summary",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Give recruiters a brief overview of the highlights of your career, key achievements and career goals to help recruiters know your profile better",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        controller: profileSummaryController,
                        maxLength: 1000,
                        decoration: InputDecoration(
                            label: Text(
                          "Profile Summary*",
                          style: TextStyle(fontSize: 15.5),
                          // softWrap: true,
                          // overflow: TextOverflow.visible,
                        )),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
