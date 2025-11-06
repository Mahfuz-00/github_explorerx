import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Common/Helper/date_formatter.dart';
import '../../Common/Helper/language_color.dart';
import '../../Domain/Entities/repo.dart';


class RepoDetailPage extends StatelessWidget {
  final Repo repo;
  const RepoDetailPage({required this.repo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 30, backgroundImage: CachedNetworkImageProvider(repo.ownerAvatar)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(repo.fullName, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text('by ${repo.ownerLogin}', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (repo.description.isNotEmpty) ...[
              Text('Description', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(repo.description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
            ],
            _buildStats(context),
            const SizedBox(height: 24),
            _buildMetadata(context),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open in GitHub'),
                onPressed: () => launchUrl(Uri.parse(repo.htmlUrl), mode: LaunchMode.externalApplication),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.2,
      children: [
        _statCard('Stars', repo.stargazersCount, Icons.star, context),
        _statCard('Forks', repo.forksCount, Icons.fork_left, context),
        _statCard('Watchers', repo.watchersCount, Icons.visibility, context),
        _statCard('Issues', repo.openIssuesCount, Icons.info, context),
        _statCard('Size', '${repo.size ?? 0} KB', Icons.storage, context),
        _statCard('Private', repo.isPrivate ? 'Yes' : 'No', Icons.lock, context),
      ],
    );
  }

  Widget _statCard(String label, dynamic value, IconData icon, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 4),
            Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Details', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        _infoTile('Language', repo.language, LanguageColor.get(repo.language), context),
        _infoTile('Created', DateFormatter.format(repo.createdAt), Icons.calendar_today, context),
        if (repo.updatedAt != null) _infoTile('Updated', DateFormatter.format(repo.updatedAt!), Icons.update, context),
        if (repo.pushedAt != null) _infoTile('Pushed', DateFormatter.format(repo.pushedAt!), Icons.push_pin, context),
        _infoTile('Forked', repo.isFork ? 'Yes' : 'No', Icons.fork_right, context),
      ],
    );
  }

  Widget _infoTile(String label, String? value, dynamic icon, BuildContext context) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return ListTile(
      leading: icon is Color
          ? Container(width: 16, height: 16, decoration: BoxDecoration(color: icon, shape: BoxShape.circle))
          : Icon(icon, size: 20),
      title: Text(label),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      contentPadding: EdgeInsets.zero,
    );
  }
}