import 'package:flutter/material.dart';

class BasicDetailsCard extends StatelessWidget {
  const BasicDetailsCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.15,
      height: size.height / 5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Basic Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 17.3),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: const [
                Row(
                  children: const [
                    Icon(
                      Icons.card_travel,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("Fresher")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("Panauti, Kavre")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.email_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("romanhumagian@gmail.com")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.phone,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("9840617106")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
