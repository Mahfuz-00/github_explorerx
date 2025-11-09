import 'package:get/get.dart';

import '../../Domain/Entities/repo.dart';
import '../../Domain/Usecases/fetch_repos.dart';
import '../../Domain/Usecases/fetch_user.dart';
import '../../Presentation/Getx/repos_controller.dart';
import '../../Presentation/Getx/user_controller.dart';
import '../../Presentation/Pages/home_page.dart';
import '../../Presentation/Pages/repo_detail_page.dart';
import '../../Presentation/Pages/splash_screen.dart';
import '../../Presentation/Pages/username_page.dart';
import '../DI/injection.dart';


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
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserController(sl<FetchUser>()));
        Get.lazyPut(() => ReposController(sl<FetchRepos>()));
      }),
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