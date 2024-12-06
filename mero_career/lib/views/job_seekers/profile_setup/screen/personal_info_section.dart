import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/profile_setup/widget/continue_skip.dart';
import 'package:mero_career/views/widgets/my_profile_textfield.dart';

class PersonalInfoSection extends StatefulWidget {
  const PersonalInfoSection({super.key});

  @override
  State<PersonalInfoSection> createState() => _PersonalInfoSectionState();
}

class _PersonalInfoSectionState extends State<PersonalInfoSection> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}"
            .split(' ')[0]; // Format date to YYYY-MM-DD
      });
    }
  }

  void onContinue() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Personal Info",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 19.6, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyProfileTextfield(
                    labelText: "Full Name",
                    prefixIcon: Icons.person,
                    verticalContentPadding: 12,
                    controller: fullNameController),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Contact Information",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    MyProfileTextfield(
                        labelText: "Phone Number",
                        prefixIcon: Icons.phone,
                        verticalContentPadding: 12,
                        controller: phoneNumberController),
                    SizedBox(
                      height: 20,
                    ),
                    MyProfileTextfield(
                        labelText: "Email Address",
                        prefixIcon: Icons.email_rounded,
                        verticalContentPadding: 12,
                        controller: emailAddressController),
                    SizedBox(
                      height: 20,
                    ),
                    MyProfileTextfield(
                        labelText: "Address",
                        prefixIcon: Icons.location_city,
                        verticalContentPadding: 12,
                        controller: addressController),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 130, bottom: 10, left: 18),
                child: Row(
                  children: [
                    Expanded(
                      // This allows the TextField to take up available space
                      child: TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                    color: Colors.grey,
                                  ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Languages",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Dynamically created language input fields
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 120, bottom: 10, left: 28),
                    child: MyProfileTextfield(
                      labelText: "Language",
                      hintText: "eg:- Nepali, English, Hindi ",
                      prefixIcon: Icons.language,
                      verticalContentPadding: 8,
                      controller: _languageController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 28.0),
              //   child: Material(
              //     elevation: 2,
              //     borderRadius: BorderRadius.circular(12),
              //     child: GestureDetector(
              //       onTap: () {
              //         _addLanguageField();
              //       },
              //       child: Container(
              //         width: size.width / 2.8,
              //         height: 39,
              //         decoration: BoxDecoration(
              //             color: Colors.transparent,
              //             borderRadius: BorderRadius.circular(12)),
              //         child: Center(
              //           child: Text(
              //             "Add Language",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 18,
              //                 color:
              //                     Theme.of(context).colorScheme.onBackground),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Center(child: ContinueSkip(onContinue: onContinue))
            ],
          ),
        ),
      ),
    );
  }
}
