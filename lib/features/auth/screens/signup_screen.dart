import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/auth/screens/login_screen.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SignUp",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: EColors.primaryColor, fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            HelperTextField(
                htxt: 'Email Address',
                iconData: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress),
            HelperTextField(
              htxt: 'Password',
              iconData: Icons.password,
              controller: _passController,
              keyboardType: TextInputType.emailAddress,
              obscure: true,
            ),
            HelperTextField(
              htxt: 'Confirm Password',
              iconData: Icons.password,
              controller: _passController,
              keyboardType: TextInputType.emailAddress,
              obscure: true,
            ),
            HelperButton(name: "SignUp", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
