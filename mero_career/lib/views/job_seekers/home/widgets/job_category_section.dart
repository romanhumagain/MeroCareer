import 'package:flutter/material.dart';

import 'category_card.dart';

class JobCategorySection extends StatelessWidget {
  const JobCategorySection({
    super.key,
    required this.size,
    required this.cardColor,
  });

  final Size size;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),

          width: size.width - 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cardColor,
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
                    Text(
                      "View All",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500),
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
                  CategoryCard(
                    size: size,
                    category: "IT & Telecommunication",
                    categoryIconUrl: 'assets/images/category/IT.png',
                  ),
                  CategoryCard(
                    size: size,
                    category: "Architecture/ Design",
                    categoryIconUrl: 'assets/images/category/architecture.png',
                  ),
                  CategoryCard(
                    size: size,
                    category: "Teaching/ Education",
                    categoryIconUrl: 'assets/images/category/teaching.png',
                  ),
                  CategoryCard(
                    size: size,
                    category: "Hospital",
                    categoryIconUrl: 'assets/images/category/hospital.png',
                  ),
                  CategoryCard(
                    size: size,
                    category: "Banking/ Insurance",
                    categoryIconUrl: 'assets/images/category/banking.png',
                  ),
                  CategoryCard(
                    size: size,
                    category: "Graphic/ Designing",
                    categoryIconUrl: 'assets/images/category/graphic.png',
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: size.width / 1.2,
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
