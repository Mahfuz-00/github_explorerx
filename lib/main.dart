import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Core/Config/Constants/constants.dart';
import 'Core/Config/Theme/app_theme.dart';
import 'Core/DI/injection.dart';
import 'Core/Navigations/app_router.dart';
import 'Presentation/Getx/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.splash,
      getPages: AppRouter.routes,
      builder: (context, child) {
        return Obx(() => AnimatedTheme(
          data: themeCtrl.isDark ? AppTheme.dark : AppTheme.light,
          duration: const Duration(milliseconds: 300), // Smooth fade
          curve: Curves.easeInOut,
          child: child!,
        ));
      },
    );
  }
}