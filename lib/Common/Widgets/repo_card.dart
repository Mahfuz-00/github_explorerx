import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Domain/Entities/repo.dart';
import '../Helper/language_color.dart';
import '../Helper/date_formatter.dart';

class RepoCard extends StatelessWidget {
  final Repo repo;
  final VoidCallback onTap;
  final bool isGrid;

  const RepoCard({
    super.key,
    required this.repo,
    required this.onTap,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Repo Name + Private Badge
              Row(
                children: [
                  Expanded(
                    child: Text(
                      repo.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (repo.isPrivate)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Private',
                        style: TextStyle(color: Colors.red, fontSize: 10),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // Description (with dynamic height preservation in grid)
              if (repo.description?.trim().isNotEmpty == true)
                _buildDescription(theme)
              else if (isGrid)
                const SizedBox(height: 10 + 2 * 18), // Reserve space for 2 lines

              const SizedBox(height: 8),

              // Language
              _buildLanguageRow(theme),

              // Stats: Stars, Forks, Watchers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(Icons.star, repo.stargazersCount, theme),
                  _buildStat(Icons.fork_left, repo.forksCount, theme),
                  _buildStat(Icons.visibility, repo.watchersCount, theme),
                ],
              ),

              const SizedBox(height: 8),

              // Updated Date
              Text(
                'Updated ${DateFormatter.format(repo.updatedAt ?? repo.createdAt)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Description with line-height preservation
  Widget _buildDescription(ThemeData theme) {
    final maxLines = isGrid ? 2 : 3;
    final text = repo.description!.trim();

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: theme.textTheme.bodyMedium),
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final usedLines = textPainter.computeLineMetrics().length;
        final lineHeight = (theme.textTheme.bodyMedium?.height ?? 1.5) * (theme.textTheme.bodyMedium?.fontSize ?? 12);
        final totalReserved = maxLines * lineHeight;
        final usedHeight = usedLines * lineHeight;
        final paddingHeight = isGrid ? (totalReserved - usedHeight).clamp(0.0, double.infinity) : 0.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: theme.textTheme.bodyMedium,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
            if (paddingHeight > 0) SizedBox(height: paddingHeight),
          ],
        );
      },
    );
  }

  // Language Row
  Widget _buildLanguageRow(ThemeData theme) {
    if (repo.language?.trim().isNotEmpty != true) {
      return isGrid ? const SizedBox(height: 12) : const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: LanguageColor.get(repo.language!),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            repo.language!,
            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Stat Item
  Widget _buildStat(IconData icon, int count, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}