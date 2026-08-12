import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
