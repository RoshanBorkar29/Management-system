import 'package:flutter/material.dart';

const _avatarColors = [
  Color(0xFF7C3AED),
  Color(0xFF2ECC71),
  Color(0xFFF39C12),
  Color(0xFF3498DB),
  Color(0xFFE91E63),
];

const _rankIcons = ['🎉', '🏅', '🎖️', '4', '5'];

class TopContributors extends StatelessWidget {
  final List<Map<String, dynamic>> contributors;

  const TopContributors({super.key, required this.contributors});

  @override
  Widget build(BuildContext context) {
    final items = contributors.asMap().entries.map((entry) {
      final i = entry.key;
      final d = entry.value;
      return Contributor(
        name: d['name'] as String,
        avatar: d['initials'] as String,
        avatarColor: _avatarColors[i % _avatarColors.length],
        tasksCompleted: d['tasksCompleted'] as int,
        icon: i < _rankIcons.length ? _rankIcons[i] : '${i + 1}',
      );
    }).toList();

    if (items.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('No contributors yet')),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🏆 ', style: TextStyle(fontSize: 20)),
              const Text(
                'Top Contributors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final contributor = entry.value;
            return _ContributorCard(contributor: contributor, rank: index + 1);
          }),
        ],
      ),
    );
  }
}

class Contributor {
  final String name;
  final String avatar;
  final Color avatarColor;
  final int tasksCompleted;
  final String icon;

  Contributor({
    required this.name,
    required this.avatar,
    required this.avatarColor,
    required this.tasksCompleted,
    required this.icon,
  });
}

class _ContributorCard extends StatelessWidget {
  final Contributor contributor;
  final int rank;

  const _ContributorCard({required this.contributor, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // rank number
          SizedBox(
            width: 24,
            child: Text(
              rank.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: contributor.avatarColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                contributor.avatar,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // name and info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contributor.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: contributor.tasksCompleted > 0
                            ? (contributor.tasksCompleted / 10).clamp(0.05, 1.0)
                            : 0.0,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: contributor.avatarColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // completed count
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  contributor.tasksCompleted.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'done',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
