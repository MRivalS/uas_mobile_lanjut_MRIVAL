import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/config/env_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const FinalProjectApp());
}

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = EnvConfig.isProduction
        ? const Color(0xFF0D47A1) 
        : Colors.orange;

    return MaterialApp.router(
      debugShowCheckedModeBanner: !EnvConfig.isProduction,
      title: EnvConfig.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: EnvConfig.isProduction
              ? Brightness.dark
              : Brightness.light,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
