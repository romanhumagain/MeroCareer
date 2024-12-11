import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/shared/login/login_page.dart';

class UnderApprovalPage extends StatefulWidget {
  const UnderApprovalPage({super.key});

  @override
  State<UnderApprovalPage> createState() => _UnderApprovalPageState();
}

class _UnderApprovalPageState extends State<UnderApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.hourglass_empty,
              color: Colors.blueAccent,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              "Your account is under review!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Our team is currently reviewing your account details. Once the review is complete, you will be notified via email. Thank you for your patience!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
              ),
              child: Text(
                "Go Back",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
