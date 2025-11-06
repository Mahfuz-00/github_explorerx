import 'package:dartz/dartz.dart';
import '../../Common/Error/failure.dart';
import '../Entities/user.dart';


abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String username);
}