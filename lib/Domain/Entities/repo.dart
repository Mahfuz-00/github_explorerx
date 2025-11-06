class Repo {
  final String name;
  final String fullName;
  final String description;
  final String language;
  final String ownerLogin;
  final String ownerAvatar;
  final int stargazersCount;
  final int forksCount;
  final int watchersCount;
  final int openIssuesCount;
  final int? size;
  final bool isPrivate;
  final bool isFork;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? pushedAt;
  final String htmlUrl;

  Repo({
    required this.name,
    required this.fullName,
    this.description = '',
    this.language = '',
    required this.ownerLogin,
    required this.ownerAvatar,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    required this.openIssuesCount,
    this.size,
    required this.isPrivate,
    required this.isFork,
    required this.createdAt,
    this.updatedAt,
    this.pushedAt,
    required this.htmlUrl,
  });
}