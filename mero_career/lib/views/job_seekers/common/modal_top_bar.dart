import 'package:flutter/material.dart';

class ModalTopBar extends StatelessWidget {
  const ModalTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 85,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
