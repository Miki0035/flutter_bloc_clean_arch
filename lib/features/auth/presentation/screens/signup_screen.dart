import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (_) => LoginScreen());

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: .all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: .bold),
              ),
              SizedBox(height: 30),
              AuthField(controller: nameController, hintText: 'Name'),
              SizedBox(height: 15),
              AuthField(controller: emailController, hintText: 'Email'),
              SizedBox(height: 15),

              AuthField(
                controller: passwordController,
                hintText: 'Password',
                isObscureText: true,
              ),
              SizedBox(height: 20),

              AuthGradientButton(buttonText: 'Sign up'),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignupScreen.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Sign In",
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
