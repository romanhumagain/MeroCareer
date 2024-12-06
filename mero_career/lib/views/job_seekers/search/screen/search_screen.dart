import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Filter options
  String? jobType = "All";
  String? experience = "All";
  String? jobLevel = "All";
  String? jobCategory = "All";

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
                  // Space between TextField and button
                  Container(
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
                ],
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
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  Text(
                    "Clear All",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Divider(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Flutter Developer",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 16)),
                  Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(2.5)),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            )
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
                      items: const ["All", "Part-Time", "Full-Time", "Remote"],
                      labelText: "Job Type",
                      initialValue: jobType!,
                      onChanged: (value) {
                        setState(() {
                          jobType = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    FilterDropdownButton(
                      items: const ["All", "Junior", "Mid-Level", "Senior"],
                      labelText: "Experience",
                      initialValue: experience!,
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
                        "Entry Level",
                        "Mid Level",
                        "Senior Level"
                      ],
                      labelText: "Job Level",
                      initialValue: jobLevel!,
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
                        "IT",
                        "Banking",
                        "Designer",
                        "Construction",
                        "Hospitality"
                      ],
                      labelText: "Job Categories",
                      initialValue: jobCategory!,
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
