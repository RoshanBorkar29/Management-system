import 'package:flutter/material.dart';

class TopContributors extends StatelessWidget {
  const TopContributors({super.key});

  @override
  Widget build(BuildContext context) {
    final contributors = [
      Contributor(
        name: 'Sarah Chen',
        avatar: 'SC',
        avatarColor: const Color(0xFF7C3AED),
        tasksCompleted: 2,
        icon: '🎉',
      ),
      Contributor(
        name: 'Priya Patel',
        avatar: 'PP',
        avatarColor: const Color(0xFF2ECC71),
        tasksCompleted: 2,
        icon: '🏅',
      ),
      Contributor(
        name: 'Marcus Johnson',
        avatar: 'MJ',
        avatarColor: const Color(0xFFF39C12),
        tasksCompleted: 1,
        icon: '🎖️',
      ),
      Contributor(
        name: 'Tom Williams',
        avatar: 'TW',
        avatarColor: Colors.blue,
        tasksCompleted: 0,
        icon: '4',
      ),
    ];

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
          ...contributors.asMap().entries.map((entry) {
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
                      Container(
                        width: (contributor.tasksCompleted / 2) * 150,
                        height: 4,
                        decoration: BoxDecoration(
                          color: contributor.avatarColor,
                          borderRadius: BorderRadius.circular(2),
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
