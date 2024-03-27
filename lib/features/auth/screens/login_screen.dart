import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/auth/controller/auth_controller.dart';
import 'package:mental_healthapp/features/auth/screens/create_profile.dart';
import 'package:mental_healthapp/features/auth/screens/forgot_pass.dart';
import 'package:mental_healthapp/features/auth/screens/signup_screen.dart';
import 'package:mental_healthapp/features/dashboard/screens/nav_screen.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';
import 'package:mental_healthapp/shared/utils/show_snackbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  Future loginUser() async {
    try {
      await ref.read(authControllerProvider).signingInUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim(),
          );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }

  Future loginWithGoogle() async {
    try {
      await ref.read(authControllerProvider).signInWithGoogle();

      final bool profileExists = await ref
          .read(authControllerProvider)
          .checkProfileExists(FirebaseAuth.instance.currentUser!.uid);
      if (profileExists && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavScreen()),
        );
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateProfile(),
            ),
          );
        }
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 15,
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
              HelperButton(name: "LogIn", onTap: loginUser),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'SignUp',
                      style:
                          TextStyle(color: EColors.primaryColor, fontSize: 16),
                    ),
                  )
                ],
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  },
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'OR',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: loginWithGoogle,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: EColors.dark,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/google.png'),
                        const Text("Login With Google"),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
