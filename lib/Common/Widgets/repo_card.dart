import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Domain/Entities/repo.dart';
import '../Helper/language_color.dart';


class RepoCard extends StatelessWidget {
  final Repo repo;
  final bool isGrid;
  final VoidCallback onTap;

  const RepoCard({required this.repo, this.isGrid = false, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: CachedNetworkImageProvider(repo.ownerAvatar),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(repo.fullName, style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 8),
              Text(repo.name, style: Theme.of(context).textTheme.titleMedium),
              if (repo.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(repo.description, maxLines: isGrid ? 1 : 2, overflow: TextOverflow.ellipsis),
              ],
              const Spacer(),
              Row(
                children: [
                  if (repo.language.isNotEmpty)
                    Row(
                      children: [
                        Container(width: 12, height: 12, color: LanguageColor.get(repo.language)),
                        const SizedBox(width: 4),
                        Text(repo.language),
                      ],
                    ),
                  const Spacer(),
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  Text('${repo.stargazersCount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}