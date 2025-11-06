import 'package:dartz/dartz.dart';
import '../../Common/Error/failure.dart';
import '../Entities/repo.dart';


abstract class ReposRepository {
  Future<Either<Failure, List<Repo>>> getRepos(String username);
}