import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../Data/Repositories/user_repository_impl.dart';
import '../../Data/Repositories/repos_repository_impl.dart';
import '../../Data/Sources/remote_data_source.dart';
import '../../Domain/Repositories/user_repository.dart';
import '../../Domain/Repositories/repos_repository.dart';
import '../../Domain/Usecases/fetch_user.dart';
import '../../Domain/Usecases/fetch_repos.dart';
import '../../Presentation/Getx/repos_controller.dart';
import '../../Presentation/Getx/theme_controller.dart';
import '../../Presentation/Getx/user_controller.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => RemoteDataSource(sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<ReposRepository>(() => ReposRepositoryImpl(sl()));

  // DO NOT resolve sl() here — just register
  sl.registerLazySingleton<FetchUser>(() => FetchUser(sl()));
  sl.registerLazySingleton<FetchRepos>(() => FetchRepos(sl()));

  //Theme
  Get.put(ThemeController(), permanent: true);
}
