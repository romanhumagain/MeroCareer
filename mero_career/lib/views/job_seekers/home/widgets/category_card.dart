import 'package:flutter/material.dart';
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_category_screen.dart';

class CategoryCard extends StatelessWidget {
  final JobCategory category;
  final Size size;

  const CategoryCard({
    super.key,
    required this.size,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    JobsByCategoryScreen(category: category)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        width: size.width / 4,
        height: size.height / 7.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            category.image.isNotEmpty
                ? Image.network(
                    category.image,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/placeholder.png',
                    // Replace with your placeholder asset path
                    height: 40,
                    fit: BoxFit.contain,
                  ),
            SizedBox(height: 2),
            Text(
              category.category,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
