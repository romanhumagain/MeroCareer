import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';

class CompanyBasicDetails extends StatelessWidget {
  const CompanyBasicDetails({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.15,
      height: size.height / 4.2,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Company Basic Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 17),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showBasicDetailsBottomSheet(context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: const [
                Row(
                  children: const [
                    Icon(
                      Icons.card_travel,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("Software Company")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("Kathmandu, bagmati")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.phone,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("+977 9840617106")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.email_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("contact@f1soft.com")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.app_registration,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("7282 2823 2823")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBasicDetailsBottomSheet(BuildContext context) {
    TextEditingController companyNameController =
        TextEditingController(text: "F1soft International Pvt.Ltd");
    TextEditingController companyTypeController =
        TextEditingController(text: "Software Company");
    TextEditingController phoneNummberController =
        TextEditingController(text: "9840617106");
    TextEditingController emailController =
        TextEditingController(text: "contact@f1soft.com");
    TextEditingController locationController =
        TextEditingController(text: "Kathmandu, Bagmati");
    TextEditingController registrationNumberController =
        TextEditingController(text: "4554 4545 4232 2323");

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return Container(
            height: size.height / 1.15,
            width: size.width,
            decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModalTopBar(),
                        SizedBox(
                          height: 24,
                        ),
                        Text("Company Basics Details",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 20)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "These are the basics details of your company. You can also update it.",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: companyNameController,
                                labelText: "Company Name",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: companyTypeController,
                                labelText: "Company Type",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: emailController,
                                labelText: "Email",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: phoneNummberController,
                                labelText: "Phone Number",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: locationController,
                                labelText: "Location",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: registrationNumberController,
                                labelText: "Registration Number",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            "Update",
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

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          label: Text(
            '$labelText*',
            style: TextStyle(fontSize: 15),
            // softWrap: true,
            // overflow: TextOverflow.visible,
          )),
    );
  }
}
