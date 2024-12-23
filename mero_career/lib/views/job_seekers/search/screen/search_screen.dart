import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/providers/search_provider.dart';
import 'package:mero_career/services/job_seeker_job_services.dart';
import 'package:mero_career/views/job_seekers/home/screen/job_details_screen.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  String jobType = "All";
  String experience = "All";
  String jobLevel = "All";
  String jobCategory = "All";
  final TextEditingController searchController = TextEditingController();

  JobSeekerJobServices jobServices = JobSeekerJobServices();
  List<dynamic>? filteredJobLists = [];
  late Future<List<dynamic>?> searchedHistory;
  bool isSearched = false;

  void handleSearch() async {
    try {
      final int? experienceValue =
          experience != "All" ? int.tryParse(experience) : null;

      final response = await jobServices.filterJob(
        job_title: searchController.text,
        job_level: jobLevel,
        experience: experienceValue,
        job_type: jobType,
        category_name: jobCategory,
      );
      if (response.statusCode == 200) {
        setState(() {
          filteredJobLists = json.decode(response.body);
          print(filteredJobLists);
        });
      } else {
        showCustomFlushbar(
          context: context,
          message: "Couldn't search job!",
          type: MessageType.error,
        );
      }
    } catch (e) {
      showCustomFlushbar(
        context: context,
        message: "An error occurred: ${e.toString()}",
        type: MessageType.error,
      );
    }
  }

  void addToSearchHistory(
      Map<String, dynamic> searchedData, Map<String, dynamic> jobData) async {
    try {
      final response = await Provider.of<SearchProvider>(context, listen: false)
          .addToSearchHistory(context, searchedData);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JobDetailsScreen(
                  jobId: jobData['id'], jobTitle: jobData['job_title'])));
    } catch (e) {
      print("Error adding to search history");
    }
  }

  void clearAllSearchHistory() async {
    try {
      await Provider.of<SearchProvider>(context, listen: false)
          .clearSearchHistory();
    } catch (e) {
      print("Error clearing search history");
    }
  }

  void removeSearchHistory(int jobId) async {
    try {
      await Provider.of<SearchProvider>(context, listen: false)
          .removeFromSearchHistory(context, jobId);
    } catch (e) {
      print("Error removing to search details");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchedHistory = _fetchSearchHistory();
  }

  Future<List<dynamic>?> _fetchSearchHistory() async {
    final response = await Provider.of<SearchProvider>(context, listen: false)
        .getRecentSearchDetails();
    if (response?.statusCode == 200) {
      return json.decode(response!.body);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Find Your Dream Job",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18.5),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please search based on job title !";
                          }
                          return null;
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors
                                      .grey, // Change color based on dark mode
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.blue, // Set focused border color
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade500,
                            ),
                          ),
                          labelText: "Search",
                          hintStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 13,
                                    letterSpacing: 0.5,
                                    color: Colors.grey,
                                  ),
                          labelStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                    color: isDarkMode
                                        ? Colors.grey.shade200
                                        : Colors.black,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _showFilters(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue.shade300,
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate() ?? false) {
                          handleSearch();
                          setState(() {
                            isSearched = true;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Job Type:- $jobType",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Experience:- $experience",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Job Level:- $jobLevel",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Job Category:- $jobCategory",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Searches",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 15.5)),
                  GestureDetector(
                    onTap: () {
                      clearAllSearchHistory();
                    },
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400,
            ),
            filteredJobLists!.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: filteredJobLists!.map((data) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    addToSearchHistory(
                                        {'job': data['id']}, data);
                                  },
                                  child: JobDetail(
                                    size: size,
                                    isDarkMode: isDarkMode,
                                    job: data,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  )
                : (isSearched
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No Job Found !",
                          style: TextStyle(fontSize: 16.5),
                        ),
                      )
                    : Consumer<SearchProvider>(
                        builder: (context, provider, child) {
                        final searchedData = provider.searchedData;
                        if (searchedData!.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No recent searched data found !",
                              style: TextStyle(fontSize: 16.5),
                            ),
                          );
                        }

                        return Column(
                          children: searchedData.map((job) {
                            return GestureDetector(
                              onTap: () {
                                addToSearchHistory(
                                    {'job': job['searched_job_details']['id']},
                                    job['searched_job_details']);
                              },
                              child: SearchedJobDetails(
                                  size: size,
                                  isDarkMode: isDarkMode,
                                  job: job['searched_job_details']),
                            );
                          }).toList(),
                        );
                      }))
          ],
        ),
      ),
    );
  }

  _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Text(
                  "Filter Job",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 18.5, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    FilterDropdownButton(
                      items: const [
                        "All",
                        "Full Time",
                        "Part Time",
                        "Internship",
                        "Remote",
                        "Freelance",
                        "Traineeship"
                      ],
                      labelText: "Job Type",
                      initialValue: jobType,
                      onChanged: (value) {
                        setState(() {
                          jobType = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FilterDropdownButton(
                      items: const ["All", "1", "2", "3", "4", "5"],
                      labelText: "Experience",
                      initialValue: experience,
                      onChanged: (value) {
                        setState(() {
                          experience = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FilterDropdownButton(
                      items: const [
                        "All",
                        "Top Level",
                        "Senior Level",
                        "Mid Level",
                        "Entry Level",
                        "Fresh Graduate"
                      ],
                      labelText: "Job Level",
                      initialValue: jobLevel,
                      onChanged: (value) {
                        setState(() {
                          jobLevel = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FilterDropdownButton(
                      items: const [
                        "All",
                        "IT & Telecommunication",
                        "Architecture & Design",
                        "Teaching & Education",
                        "Hospital",
                        "Accounting & Finance",
                        "Banking & Insurance",
                        "Graphic Designing",
                        "Construction",
                        "Others"
                      ],
                      labelText: "Job Categories",
                      initialValue: jobCategory,
                      onChanged: (value) {
                        setState(() {
                          jobCategory = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class JobDetail extends StatelessWidget {
  const JobDetail({
    super.key,
    required this.size,
    required this.isDarkMode,
    required this.job,
  });

  final Size size;
  final bool isDarkMode;
  final Map<String, dynamic> job;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      job['recruiter_details']['company_profile_image'] != null
                          ? Image.network(
                              job['recruiter_details']['company_profile_image'],
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/company_logo/default_company_pic.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job['job_title'],
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 16.8)),
                    Text("By ${job['recruiter_details']['company_name']}")
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}

class SearchedJobDetails extends StatelessWidget {
  const SearchedJobDetails({
    super.key,
    required this.size,
    required this.isDarkMode,
    required this.job,
  });

  final Size size;
  final bool isDarkMode;
  final Map<String, dynamic> job;

  @override
  Widget build(BuildContext context) {
    void removeSearchHistory(int jobId) async {
      try {
        await Provider.of<SearchProvider>(context, listen: false)
            .removeFromSearchHistory(context, jobId);
      } catch (e) {
        print("Error removing to search details");
      }
    }

    return Column(
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: job['recruiter_details']
                                  ['company_profile_image'] !=
                              null
                          ? Image.network(
                              job['recruiter_details']['company_profile_image'],
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/company_logo/default_company_pic.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job['job_title'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.8)),
                        Text("By ${job['recruiter_details']['company_name']}")
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    removeSearchHistory(job['id']);
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}

class FilterDropdownButton extends StatefulWidget {
  final List<String> items;
  final String labelText;
  final String initialValue;
  final ValueChanged<String> onChanged; // Callback for parent

  const FilterDropdownButton({
    super.key,
    required this.items,
    required this.labelText,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<FilterDropdownButton> createState() => _FilterDropdownButtonState();
}

class _FilterDropdownButtonState extends State<FilterDropdownButton> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      value: selectedValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: widget.items
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onChanged(value!);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        labelText: widget.labelText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade500,
            width: 1.5,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
