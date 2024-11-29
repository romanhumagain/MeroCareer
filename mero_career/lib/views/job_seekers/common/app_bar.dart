import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      title: Row(
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            height: 40,
          ),
          const SizedBox(width: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "MeroCareer",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                "Your Career, Your Path",
                style: TextStyle(color: Colors.grey, fontSize: 9.5),
              )
            ],
          )
        ],
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
