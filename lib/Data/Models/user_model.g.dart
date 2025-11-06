// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  login: json['login'] as String,
  name: json['name'] as String?,
  avatar_url: json['avatar_url'] as String,
  bio: json['bio'] as String?,
  public_repos: (json['public_repos'] as num).toInt(),
  followers: (json['followers'] as num).toInt(),
  following: (json['following'] as num).toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'login': instance.login,
  'name': instance.name,
  'avatar_url': instance.avatar_url,
  'bio': instance.bio,
  'public_repos': instance.public_repos,
  'followers': instance.followers,
  'following': instance.following,
};
