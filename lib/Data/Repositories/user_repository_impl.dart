import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../Common/Error/failure.dart';
import '../../Domain/Entities/user.dart';
import '../../Domain/Repositories/user_repository.dart';
import '../Sources/remote_data_source.dart';


class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remote;
  UserRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, User>> getUser(String username) async {
    try {
      final model = await remote.getUser(username);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}