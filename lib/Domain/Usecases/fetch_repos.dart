import 'package:dartz/dartz.dart';

import '../../Common/Error/failure.dart';
import '../../Domain/Entities/repo.dart';
import '../../Domain/Repositories/repos_repository.dart';


class FetchRepos {
  final ReposRepository repository;
  FetchRepos(this.repository);

  Future<Either<Failure, List<Repo>>> call(String username) {
    return repository.getRepos(username);
  }
}