import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String categoryIconUrl;

  const CategoryCard(
      {super.key,
      required this.size,
      required this.category,
      required this.categoryIconUrl});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Image.asset(
            categoryIconUrl,
            height: 40,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            category,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}
