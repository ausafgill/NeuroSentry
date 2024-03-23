import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/auth/screens/get_started.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 183, 249, 252),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            "Self Care Comes First",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Spacer(),
          HelperButton(
            name: "I'm New here",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetStarted()));
            },
          ),
          HelperButton(
            name: "I have an account",
            color: const Color.fromARGB(255, 181, 174, 174),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
