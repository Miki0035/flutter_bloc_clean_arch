import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (_) => SignupScreen());

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: .all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: .bold),
              ),
              SizedBox(height: 30),
              AuthField(controller: emailController, hintText: 'Email'),
              SizedBox(height: 15),

              AuthField(
                controller: passwordController,
                hintText: 'Password',
                isObscureText: true,
              ),
              SizedBox(height: 20),

              AuthGradientButton(buttonText: 'Sign in'),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginScreen.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: .bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
