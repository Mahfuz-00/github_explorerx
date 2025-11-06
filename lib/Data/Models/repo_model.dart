import 'package:json_annotation/json_annotation.dart';

import '../../Domain/Entities/repo.dart';

part 'repo_model.g.dart';

@JsonSerializable()
class RepoModel {
  final String name;
  final String full_name;
  final String? description;
  final String? language;
  final OwnerModel owner;
  final int stargazers_count;
  final int forks_count;
  final int watchers_count;
  final int open_issues_count;
  final int? size;
  final bool private;
  final bool fork;
  final String created_at;
  final String? updated_at;
  final String? pushed_at;
  final String html_url;

  RepoModel({
    required this.name,
    required this.full_name,
    this.description,
    this.language,
    required this.owner,
    required this.stargazers_count,
    required this.forks_count,
    required this.watchers_count,
    required this.open_issues_count,
    this.size,
    required this.private,
    required this.fork,
    required this.created_at,
    this.updated_at,
    this.pushed_at,
    required this.html_url,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) => _$RepoModelFromJson(json);
  Map<String, dynamic> toJson() => _$RepoModelToJson(this);

  Repo toEntity() => Repo(
    name: name,
    fullName: full_name,
    description: description ?? '',
    language: language ?? '',
    ownerLogin: owner.login,
    ownerAvatar: owner.avatar_url,
    stargazersCount: stargazers_count,
    forksCount: forks_count,
    watchersCount: watchers_count,
    openIssuesCount: open_issues_count,
    size: size,
    isPrivate: private,
    isFork: fork,
    createdAt: DateTime.parse(created_at),
    updatedAt: updated_at != null ? DateTime.parse(updated_at!) : null,
    pushedAt: pushed_at != null ? DateTime.parse(pushed_at!) : null,
    htmlUrl: html_url,
  );
}

@JsonSerializable()
class OwnerModel {
  final String login;
  final String avatar_url;

  OwnerModel({required this.login, required this.avatar_url});

  factory OwnerModel.fromJson(Map<String, dynamic> json) => _$OwnerModelFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}


//dart run build_runner build --delete-conflicting-outputs