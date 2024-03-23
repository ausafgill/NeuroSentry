import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/auth/screens/forgot_pass.dart';
import 'package:mental_healthapp/features/auth/screens/signup_screen.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              HelperButton(name: "LogIn", onTap: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
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
                                builder: (context) => ForgotPassword()));
                      },
                      child: const Text('Forgot password?'))),
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
              Container(
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
                      Text("Login With Google")
                    ],
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
