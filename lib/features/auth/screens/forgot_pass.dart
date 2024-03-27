import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/auth/controller/auth_controller.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future resetPassword() async {
    await ref
        .read(authControllerProvider)
        .resetPassword(email: _emailController.text);

    if (mounted) {
      Navigator.pop(context);
    }
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
            HelperButton(
              name: "Reset Password",
              onTap: resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
