import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_organization/company_job_lists.dart';

class ViewJobsByCompany extends StatelessWidget {
  const ViewJobsByCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AvailableCompany(
                size: size,
                jobCategory: "IT / Telecommunication",
              ),
              AvailableCompany(
                size: size,
                jobCategory: "Accounting / Finance",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvailableCompany extends StatelessWidget {
  final String jobCategory;

  const AvailableCompany(
      {super.key, required this.size, required this.jobCategory});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jobCategory,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 18.5),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CompanyCard(
                  size: size,
                  companyName: "Cotiviti Nepal",
                  imageUrl: 'assets/images/company_logo/cotiviti.jpg',
                ),
                SizedBox(
                  width: 20,
                ),
                CompanyCard(
                  size: size,
                  companyName: "Deerwalk Inc",
                  imageUrl: 'assets/images/company_logo/deerwalk.jpg',
                ),
                SizedBox(
                  width: 20,
                ),
                CompanyCard(
                  size: size,
                  companyName: "F1soft International Pvt.Ltd",
                  imageUrl: 'assets/images/company_logo/f1.jpg',
                ),
                SizedBox(
                  width: 20,
                ),
                CompanyCard(
                  size: size,
                  companyName: "LeapFrog Pvt.Ltd",
                  imageUrl: 'assets/images/company_logo/leapfrog.jpg',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final String companyName;
  final String imageUrl;

  const CompanyCard({
    super.key,
    required this.size,
    required this.companyName,
    required this.imageUrl,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompanyJobLists(
                    companyName: "F1soft International Pvt.Ltd")));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: size.width / 3.5,
        height: size.height / 6,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              companyName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2),
            )
          ],
        ),
      ),
    );
  }
}
