import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Core/Config/Theme/app_theme.dart';
import 'Core/DI/injection.dart';
import 'Core/Navigations/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GitHub Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.splash,
      getPages: AppRouter.routes,
    );
  }
}