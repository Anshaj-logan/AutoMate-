import 'package:auto_mate/core/providers/auth_provider.dart';
import 'package:auto_mate/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_mate/features/auth/auth.dart';
import 'package:auto_mate/features/home/home_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..loadUser(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return MaterialApp(
          title: 'Vehicle Service App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: Builder(
  builder: (context) {
    if (!auth.hasInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!auth.hasCompletedOnboarding) {
      return const OnboardingScreen();
    }

    if (auth.isAuthenticated) {
      return const HomeScreen();
    }

    return const AuthScreen();
  },
),

        );
      },
    );
  }

  Widget _buildInitialScreen(AuthProvider auth) {
    if (!auth.hasInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (auth.isAuthenticated) {
      return const HomeScreen();
    }

    // Add onboarding logic here if needed
    return const AuthScreen(); // 👈 direct to AuthScreen instead of named route
  }
}
