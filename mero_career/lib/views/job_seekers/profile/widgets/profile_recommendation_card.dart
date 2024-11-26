import 'package:flutter/material.dart';

class ProfileRecommendationCard extends StatelessWidget {
  final String percentageCover;
  final IconData icon;
  final String heading;
  final String buttonTitle;
  final Function onTap;
  final bool hasData;

  const ProfileRecommendationCard(
      {super.key,
      required this.size,
      required this.percentageCover,
      required this.icon,
      required this.heading,
      required this.buttonTitle,
      required this.onTap,
      required this.hasData});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: size.height,
      width: size.width / 2.9,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color:
                          hasData ? Colors.green.shade100 : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20)),
                  child: hasData
                      ? Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 14.2,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 14.2,
                        ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: hasData ? Colors.green : Colors.red,
                      size: 18,
                    ),
                    Text(
                      "$percentageCover %",
                      style: TextStyle(
                          color: hasData ? Colors.green : Colors.red,
                          letterSpacing: 0.1,
                          fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              icon,
              color: Colors.blue.shade700,
              size: 19,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.all(3.1),
              width: size.width / 3.5,
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  buttonTitle,
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
