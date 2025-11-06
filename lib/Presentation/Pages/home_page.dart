import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/Widgets/filter_bar.dart';
import '../../Common/Widgets/repo_card.dart';
import '../../Core/DI/injection.dart';
import '../../Domain/Entities/repo.dart';
import '../../Domain/Usecases/fetch_repos.dart';
import '../../Domain/Usecases/fetch_user.dart';
import '../../Presentation/Getx/repos_controller.dart';
import '../../Presentation/Getx/user_controller.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.put(UserController(sl<FetchUser>()), permanent: true);
    final reposCtrl = Get.put(ReposController(sl<FetchRepos>()), permanent: true);

    // Load data
    userCtrl.loadUser(username);
    reposCtrl.loadRepos(username);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // User Header
            Obx(() {
              if (userCtrl.isLoading.value) {
                return const LinearProgressIndicator();
              }
              if (userCtrl.user.value == null) {
                return const SizedBox.shrink();
              }

              final user = userCtrl.user.value!;
              return _buildUserHeader(user, context, isDark, theme);
            }),

            const FilterBar(),

            // Repos List/Grid
            Expanded(
              child: Obx(() {
                if (reposCtrl.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (reposCtrl.error.value != null) {
                  return Center(child: Text(reposCtrl.error.value!));
                }
                if (reposCtrl.filtered.isEmpty) {
                  return const Center(child: Text('No repositories'));
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: reposCtrl.isGrid.value
                      ? _buildGrid(reposCtrl.filtered)
                      : _buildList(reposCtrl.filtered),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(
      dynamic user, BuildContext context, bool isDark, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 36,
                backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 16),

              // Name & Bio
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? user.login,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@${user.login}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (user.bio != null && user.bio.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.bio,
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stats + Theme Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatChip(user.publicRepos, 'Repos', Icons.folder_open, theme),
              _buildStatChip(user.followers, 'Followers', Icons.people, theme),
              _buildStatChip(user.following, 'Following', Icons.person_add, theme),

              // Theme Toggle
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                  tooltip: isDark ? 'Light Mode' : 'Dark Mode',
                  onPressed: () {
                    Get.changeThemeMode(
                      isDark ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(int count, String label, IconData icon, ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<Repo> repos) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return RepoCard(
          repo: repo,
          onTap: () => Get.toNamed('/detail', arguments: repo),
        );
      },
    );
  }

  Widget _buildGrid(List<Repo> repos) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return RepoCard(
          repo: repo,
          isGrid: true,
          onTap: () => Get.toNamed('/detail', arguments: repo),
        );
      },
    );
  }
}