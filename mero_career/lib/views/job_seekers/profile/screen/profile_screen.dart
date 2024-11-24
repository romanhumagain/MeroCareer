import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage(
                'assets/images/pp.jpg',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Roman Humagain",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 18, letterSpacing: 0.4),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Backend Developer || Mobile App Developer",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 15, letterSpacing: 0.4),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 10),
            BasicDetailsCard(size: size),
            SizedBox(
              height: 15,
            ),
            Container(
              width: size.width / 1.15,
              height: size.height / 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile Summary",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 17.2),
                      ),
                      Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Highlight your key career achievements to help recruiters knows your potential",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

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
