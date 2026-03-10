import 'package:flutter/material.dart';

class DeadlinesAtRisk extends StatelessWidget {
  const DeadlinesAtRisk({super.key});

  @override
  Widget build(BuildContext context) {
    final riskTasks = [
      RiskTask(
        name: 'Payroll Integration',
        project: 'HR Management System',
        avatar: 'PP',
        avatarColor: Colors.teal,
        daysOverdue: '43d over',
      ),
      RiskTask(
        name: 'Reporting Dashboard',
        project: 'HR Management System',
        avatar: 'AK',
        avatarColor: Colors.blue,
        daysOverdue: '27d over',
      ),
      RiskTask(
        name: 'User Acceptance Testing',
        project: 'HR Management System',
        avatar: 'TW',
        avatarColor: Colors.blue,
        daysOverdue: '17d over',
      ),
      RiskTask(
        name: 'Checkout Flow Optimization',
        project: 'E-Commerce Platform Redesign',
        avatar: 'SC',
        avatarColor: Colors.purple,
        daysOverdue: '15d over',
      ),
      RiskTask(
        name: 'Performance Optimization',
        project: 'E-Commerce Platform Redesign',
        avatar: 'AK',
        avatarColor: Colors.purple,
        daysOverdue: '12d over',
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
                child: const Text(
                  '6',
                  style: TextStyle(
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
