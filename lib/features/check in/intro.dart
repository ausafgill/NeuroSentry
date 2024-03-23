import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/check%20in/questions.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

class CheckInIntro extends StatefulWidget {
  const CheckInIntro({super.key});

  @override
  State<CheckInIntro> createState() => _CheckInIntroState();
}

class _CheckInIntroState extends State<CheckInIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
        title: Text(
          "Mental Health CheckIn",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello There,',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Hope you are doing great, I have few questions lined up for you to understand your well-being...",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/a.png',
                  ),
                )),
              ),
            ),
            Spacer(),
            Center(
              child: HelperButton(
                  name: 'Lets Get Started',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionScreen()));
                  }),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
