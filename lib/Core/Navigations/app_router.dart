import 'package:get/get.dart';

import '../../Domain/Entities/repo.dart';
import '../../Presentation/Pages/home_page.dart';
import '../../Presentation/Pages/repo_detail_page.dart';
import '../../Presentation/Pages/splash_screen.dart';
import '../../Presentation/Pages/username_page.dart';


class AppRouter {
  static const String splash = '/splash';
  static const String username = '/';
  static const String home = '/home';
  static const String detail = '/detail';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: username, page: () => const UsernamePage()),
    GetPage(
      name: home,
      page: () => HomePage(username: Get.parameters['username']!),
    ),
    GetPage(
      name: detail,
      page: () {
        final repo = Get.arguments as Repo;
        return RepoDetailPage(repo: repo);
      },
    ),
  ];
}