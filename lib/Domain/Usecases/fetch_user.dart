import 'package:dartz/dartz.dart';

import '../../Common/Error/failure.dart';
import '../../Domain/Entities/user.dart';
import '../../Domain/Repositories/user_repository.dart';


class FetchUser {
  final UserRepository repository;
  FetchUser(this.repository);

  Future<Either<Failure, User>> call(String username) {
    return repository.getUser(username);
  }
}