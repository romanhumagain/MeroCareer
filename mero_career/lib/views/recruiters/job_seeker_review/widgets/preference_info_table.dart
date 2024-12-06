import 'package:flutter/material.dart';

class PreferenceInfoTable extends StatelessWidget {
  final Size size;
  final String data;
  final String value;

  const PreferenceInfoTable(
      {super.key, required this.size, required this.data, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: size.width / 2.5,
          child: Text(
            data,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Row(
          children: [
            Text(
              ": ",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.all(3),
              width: size.width / 2.3,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                " $value",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2),
              ),
            ),
          ],
        )
      ],
    );
  }
}
