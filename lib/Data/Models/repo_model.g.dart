// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoModel _$RepoModelFromJson(Map<String, dynamic> json) => RepoModel(
  name: json['name'] as String,
  full_name: json['full_name'] as String,
  description: json['description'] as String?,
  language: json['language'] as String?,
  owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
  stargazers_count: (json['stargazers_count'] as num).toInt(),
  forks_count: (json['forks_count'] as num).toInt(),
  watchers_count: (json['watchers_count'] as num).toInt(),
  open_issues_count: (json['open_issues_count'] as num).toInt(),
  size: (json['size'] as num?)?.toInt(),
  private: json['private'] as bool,
  fork: json['fork'] as bool,
  created_at: json['created_at'] as String,
  updated_at: json['updated_at'] as String?,
  pushed_at: json['pushed_at'] as String?,
  html_url: json['html_url'] as String,
);

Map<String, dynamic> _$RepoModelToJson(RepoModel instance) => <String, dynamic>{
  'name': instance.name,
  'full_name': instance.full_name,
  'description': instance.description,
  'language': instance.language,
  'owner': instance.owner,
  'stargazers_count': instance.stargazers_count,
  'forks_count': instance.forks_count,
  'watchers_count': instance.watchers_count,
  'open_issues_count': instance.open_issues_count,
  'size': instance.size,
  'private': instance.private,
  'fork': instance.fork,
  'created_at': instance.created_at,
  'updated_at': instance.updated_at,
  'pushed_at': instance.pushed_at,
  'html_url': instance.html_url,
};

OwnerModel _$OwnerModelFromJson(Map<String, dynamic> json) => OwnerModel(
  login: json['login'] as String,
  avatar_url: json['avatar_url'] as String,
);

Map<String, dynamic> _$OwnerModelToJson(OwnerModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatar_url,
    };
