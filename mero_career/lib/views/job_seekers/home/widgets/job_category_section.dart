import 'package:flutter/material.dart';
import 'package:mero_career/services/job_services.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_category_screen.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_organization/view_jobs_by_company.dart';

import '../../../../models/job/job_category_model.dart';
import 'category_card.dart';

class JobCategorySection extends StatefulWidget {
  const JobCategorySection({
    super.key,
    required this.size,
    required this.cardColor,
  });

  final Size size;
  final Color cardColor;

  @override
  State<JobCategorySection> createState() => _JobCategorySectionState();
}

class _JobCategorySectionState extends State<JobCategorySection> {
  bool _setViewAll = false;

  late Future<List<JobCategory>> _jobCategories;

  @override
  void initState() {
    super.initState();
    _jobCategories = JobServices().getJobCategories();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),

          width: widget.size.width - 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.cardColor,
          ),
          // height: size.height / 4,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Browse jobs by Category",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _setViewAll = !_setViewAll;
                        });
                      },
                      child: Text(
                        _setViewAll ? "View Less" : "View All",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: _jobCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 140,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("No Categories Found !"),
                      );
                    } else {
                      final categories = snapshot.data;
                      return Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: categories!
                            .take(_setViewAll ? categories.length : 6)
                            .map((category) {
                          return CategoryCard(size: size, category: category);
                        }).toList(),
                      );
                    }
                  }),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewJobsByCompany()));
                },
                child: Container(
                  width: widget.size.width / 1.2,
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue, // Set the border color to blue
                      width: 2.0, // Optional: Set the border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "View Jobs by Organization",
                        style: TextStyle(color: Colors.blue, fontSize: 15.5),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.corporate_fare,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
