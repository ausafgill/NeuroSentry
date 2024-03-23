import 'package:flutter/material.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
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
              "Forgot Password?",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Enter your email address we will send you confirmation code",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            HelperTextField(
                htxt: "Email Address",
                iconData: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress),
            HelperButton(name: "Reset Password", onTap: () {})
          ],
        ),
      ),
    );
  }
}
