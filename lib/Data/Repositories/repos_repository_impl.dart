import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../Common/Error/failure.dart';
import '../../Domain/Entities/repo.dart';
import '../../Domain/Repositories/repos_repository.dart';
import '../Sources/remote_data_source.dart';


class ReposRepositoryImpl implements ReposRepository {
  final RemoteDataSource remote;
  ReposRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Repo>>> getRepos(String username) async {
    try {
      final models = await remote.getRepos(username);
      return Right(models.map((m) => m.toEntity()).toList());
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}