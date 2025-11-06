import 'package:dio/dio.dart';
import '../../Core/Config/Constants/api_constants.dart';
import '../Models/repo_model.dart';
import '../Models/user_model.dart';


class RemoteDataSource {
  final Dio dio;
  RemoteDataSource(this.dio);

  Future<UserModel> getUser(String username) async {
    final response = await dio.get(ApiConstants.user(username));
    return UserModel.fromJson(response.data);
  }

  Future<List<RepoModel>> getRepos(String username) async {
    final response = await dio.get(ApiConstants.repos(username));
    return (response.data as List).map((e) => RepoModel.fromJson(e)).toList();
  }
}