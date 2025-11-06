import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Domain/Entities/user.dart';

class UserHeader extends StatelessWidget {
  final User user;
  const UserHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                Text('@${user.login}', style: Theme.of(context).textTheme.bodyMedium),
                if (user.bio.isNotEmpty) Text(user.bio, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            children: [
              Text('${user.publicRepos}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text('Repos'),
              const SizedBox(height: 8),
              Text('${user.followers}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text('Followers'),
            ],
          ),
        ],
      ),
    );
  }
}