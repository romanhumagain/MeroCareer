import 'package:flutter/material.dart';

import '../../widgets/job_details_card.dart';

class CompanyJobLists extends StatelessWidget {
  final String companyName;

  const CompanyJobLists({super.key, required this.companyName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(companyName),
        toolbarHeight: 65,
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              // Job image at the top
              SizedBox(
                width: size.width,
                height: size.height / 6.9,
                child: Image.asset(
                  'assets/images/job_details/hiring2.webp',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Company info
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/company_logo/f1.jpg',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "F1soft International pvt.ltd",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Software Companies",
                          style: TextStyle(color: Colors.grey, fontSize: 13.5),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  dividerColor: Theme.of(context).colorScheme.surfaceContainer,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.info_outline),
                      text: "About",
                    ),
                    Tab(
                      icon: Icon(Icons.info_outline),
                      text: "Jobs Opening ",
                    )
                  ]),
              Expanded(
                child: TabBarView(
                  children: [AboutCompany(), JobOpeningLists()],
                ),
              )
            ],
          )),
    );
  }
}

class AboutCompany extends StatelessWidget {
  const AboutCompany({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        "F1Soft International Pvt. Ltd. is a leading fintech company based in Nepal, pioneering digital financial solutions since its inception in 2004. Renowned for its innovative products, F1Soft has revolutionized the banking and financial sector by introducing services like mobile banking, digital wallets, and payment gateways. Its flagship product, eSewa, is Nepal’s first and most popular digital wallet, empowering millions of users with seamless online payments. With a commitment to driving financial inclusion and technological excellence, F1Soft continues to shape the future of digital finance, offering secure, user-friendly, and reliable solutions tailored to meet diverse customer needs.",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
      ),
    );
  }
}

class JobOpeningLists extends StatelessWidget {
  const JobOpeningLists({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          JobDetailsCard(
            size: size,
            cardColor: cardColor,
            tertiaryColor: tertiaryColor,
            jobTitle: "AI Engineer ",
            companyName: "F1 soft International pvt.ltd",
            deadline: "2 hours and 51",
            imageUrl: 'assets/images/company_logo/f1.jpg',
          ),
          SizedBox(
            height: 10,
          ),
          JobDetailsCard(
            size: size,
            cardColor: cardColor,
            tertiaryColor: tertiaryColor,
            jobTitle: "Senior Software Engineer",
            companyName: "LeapFrog Technology LTD",
            deadline: "2 hours and 51",
            imageUrl: 'assets/images/company_logo/leapfrog.jpg',
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
