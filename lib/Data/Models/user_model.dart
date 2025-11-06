import 'package:json_annotation/json_annotation.dart';
import '../../Domain/Entities/user.dart';


part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String login;
  final String? name;
  final String avatar_url;
  final String? bio;
  final int public_repos;
  final int followers;
  final int following;

  UserModel({
    required this.login,
    this.name,
    required this.avatar_url,
    this.bio,
    required this.public_repos,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
    login: login,
    name: name ?? login,
    avatarUrl: avatar_url,
    bio: bio ?? '',
    publicRepos: public_repos,
    followers: followers,
    following: following,
  );
}