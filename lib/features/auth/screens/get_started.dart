import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/auth/screens/login_screen.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
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
          Text(
            'Welcome to',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Neuro Sentry',
            style: TextStyle(color: EColors.primaryColor, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "We are so glad to see you here",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'We help you get stronger emotionally',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          HelperButton(
            name: 'Get Started',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
