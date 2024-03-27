import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/auth/controller/auth_controller.dart';
import 'package:mental_healthapp/features/auth/screens/create_profile.dart';
import 'package:mental_healthapp/features/auth/screens/login_screen.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';
import 'package:mental_healthapp/shared/utils/show_snackbar.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
  }

  Future signUpUser() async {
    if (_confirmPassController.text != _passController.text) {
      showSnackBar(
          context: context,
          content: "Confirm Password and Password don't match");
      return;
    }
    try {
      await ref.read(authControllerProvider).creatingUserWithEmailPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim(),
          );
      if (mounted) {
        Navigator.pushReplacementNamed(context, CreateProfile.routeName);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context: context, content: e.toString());
      }
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
              "SignUp",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
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
              controller: _confirmPassController,
              keyboardType: TextInputType.emailAddress,
              obscure: true,
            ),
            HelperButton(name: "SignUp", onTap: signUpUser),
          ],
        ),
      ),
    );
  }
}
