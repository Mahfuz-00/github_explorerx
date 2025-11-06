import 'package:get/get.dart';

import '../../Domain/Entities/user.dart';
import '../../Domain/Usecases/fetch_user.dart';


class UserController extends GetxController {
  final FetchUser fetchUser;
  UserController(this.fetchUser);

  var isLoading = true.obs;
  final user = Rxn<User>();
  var error = RxnString();

  Future<void> loadUser(String username) async {
    isLoading(true);
    error(null);
    final result = await fetchUser(username);
    result.fold(
          (failure) => error(failure.message),
          (data) => user.value = data as User?,
    );
    isLoading(false);
  }
}