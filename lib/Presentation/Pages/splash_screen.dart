import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Navigations/app_router.dart';
import '../../Core/Config/Constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRouter.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // GitHub dark background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GitHub Logo
            Image.asset(
              'Assets/Images/github-logo.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              color: Colors.white,
            ),

            const SizedBox(height: 60),

            // App Name
            Text(
              AppConstants.appName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}