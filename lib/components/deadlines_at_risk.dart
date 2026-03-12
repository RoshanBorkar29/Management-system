import 'package:flutter/material.dart';
import 'package:managementt/model/task.dart';

const _avatarColors = [
  Colors.teal,
  Colors.blue,
  Colors.purple,
  Colors.indigo,
  Colors.deepOrange,
];

class DeadlinesAtRisk extends StatelessWidget {
  final List<Task> tasks;
  final String Function(String ownerId) getMemberName;
  final String Function(String ownerId) getMemberInitials;

  const DeadlinesAtRisk({
    super.key,
    required this.tasks,
    required this.getMemberName,
    required this.getMemberInitials,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final riskTasks = tasks.asMap().entries.map((entry) {
      final i = entry.key;
      final t = entry.value;
      final daysOver = t.deadLine != null
          ? today.difference(t.deadLine!).inDays
          : 0;
      return RiskTask(
        name: t.title,
        project: t.description,
        avatar: getMemberInitials(t.ownerId),
        avatarColor: _avatarColors[i % _avatarColors.length],
        daysOverdue: daysOver > 0 ? '${daysOver}d over' : 'due',
      );
    }).toList();

    if (riskTasks.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('No deadlines at risk')),
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
              const Text(
                'Deadlines at Risk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${riskTasks.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...riskTasks.map((task) => _RiskTaskCard(task: task)),
        ],
      ),
    );
  }
}

class RiskTask {
  final String name;
  final String project;
  final String avatar;
  final Color avatarColor;
  final String daysOverdue;

  RiskTask({
    required this.name,
    required this.project,
    required this.avatar,
    required this.avatarColor,
    required this.daysOverdue,
  });
}

class _RiskTaskCard extends StatelessWidget {
  final RiskTask task;

  const _RiskTaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.08), width: 1),
      ),
      child: Row(
        children: [
          // Left indicator line
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          // Task details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  task.project,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Avatar and days overdue
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: task.avatarColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    task.avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                task.daysOverdue,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
