import 'package:blog_app/app.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    publishableKey: AppSecrets.publishableKey,
  );

  /// runApp already has WidgesFlutterBinding.initialize
  runApp(const MyApp());
}
