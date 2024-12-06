import 'package:flutter/material.dart';

import '../../../models/job/job_category_model.dart';
import '../../job_seekers/common/modal_top_bar.dart';

class JobCategoryModal extends StatelessWidget {
  final Future<List<JobCategory>> jobCategoriesFuture;
  final String? selectedCategory;
  final void Function(String categoryName, String categoryId)
      onCategorySelected;

  const JobCategoryModal({
    super.key,
    required this.jobCategoriesFuture,
    required this.onCategorySelected,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: size.height / 1.8,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            const ModalTopBar(),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Preferred Job Category",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18.5),
                  ),
                  selectedCategory == null || selectedCategory!.isEmpty
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Close modal
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<List<JobCategory>>(
                  future: jobCategoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No categories available"),
                      );
                    }

                    final categories = snapshot.data!;

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            onCategorySelected(
                              category.category,
                              category.id.toString(),
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              category.category,
                              style: const TextStyle(fontSize: 16.4),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
