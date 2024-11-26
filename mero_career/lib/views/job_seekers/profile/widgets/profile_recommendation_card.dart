import 'package:flutter/material.dart';

class ProfileRecommendationCard extends StatelessWidget {
  final String percentageCover;
  final IconData icon;
  final String heading;
  final String buttonTitle;
  final Function onTap;

  const ProfileRecommendationCard(
      {super.key,
      required this.size,
      required this.percentageCover,
      required this.icon,
      required this.heading,
      required this.buttonTitle,
      required this.onTap});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 18,
                  ),
                  Text(
                    "$percentageCover %",
                    style: TextStyle(
                        color: Colors.green, letterSpacing: 0.1, fontSize: 12),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
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
            height: 8,
          ),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(
            height: 14,
          ),
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
