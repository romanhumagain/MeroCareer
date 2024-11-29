import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_category_screen.dart';

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

  @override
  Widget build(BuildContext context) {
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
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsByCategoryScreen(
                                  category: 'IT & Telecommunication')));
                    },
                    child: CategoryCard(
                      size: widget.size,
                      category: "IT & Telecommunication",
                      categoryIconUrl: 'assets/images/category/IT.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsByCategoryScreen(
                                  category: 'Architecture & Design')));
                    },
                    child: CategoryCard(
                      size: widget.size,
                      category: "Architecture/ Design",
                      categoryIconUrl:
                          'assets/images/category/architecture.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsByCategoryScreen(
                                  category: 'Teaching & Education')));
                    },
                    child: CategoryCard(
                      size: widget.size,
                      category: "Teaching/ Education",
                      categoryIconUrl: 'assets/images/category/teaching.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JobsByCategoryScreen(category: 'Hospital')));
                    },
                    child: CategoryCard(
                      size: widget.size,
                      category: "Hospital",
                      categoryIconUrl: 'assets/images/category/hospital.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsByCategoryScreen(
                                  category: 'Banking & Insurance')));
                    },
                    child: CategoryCard(
                      size: widget.size,
                      category: "Banking/ Insurance",
                      categoryIconUrl: 'assets/images/category/banking.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsByCategoryScreen(
                                  category: 'Graphic / Designing')));
                    },
                    child: CategoryCard(
                      size: widget.size,
                      category: "Graphic/ Designing",
                      categoryIconUrl: 'assets/images/category/graphic.png',
                    ),
                  ),
                  _setViewAll
                      ? Wrap(spacing: 15, runSpacing: 15, children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobsByCategoryScreen(
                                              category: 'Accounting')));
                            },
                            child: CategoryCard(
                              size: widget.size,
                              category: "Accounting",
                              categoryIconUrl:
                                  'assets/images/category/accounting.png',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobsByCategoryScreen(
                                              category: 'Construction')));
                            },
                            child: CategoryCard(
                              size: widget.size,
                              category: "Construction",
                              categoryIconUrl:
                                  'assets/images/category/construction.png',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobsByCategoryScreen(
                                              category: 'Others')));
                            },
                            child: CategoryCard(
                              size: widget.size,
                              category: "Others",
                              categoryIconUrl:
                                  'assets/images/category/others.png',
                            ),
                          ),
                        ])
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
