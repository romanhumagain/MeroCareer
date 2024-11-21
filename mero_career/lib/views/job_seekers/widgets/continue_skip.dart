import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_button.dart';

class ContinueSkip extends StatefulWidget {
  final Function onContinue;

  const ContinueSkip({super.key, required this.onContinue});

  @override
  State<ContinueSkip> createState() => _ContinueSkipState();
}

class _ContinueSkipState extends State<ContinueSkip> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        MyButton(
            color: Colors.blue,
            width: size.width / 1.2,
            height: 45,
            text: "Save & Continue",
            onTap: widget.onContinue),
        SizedBox(
          height: 20,
        ),
        Text(
          "Skip For Now ?",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
