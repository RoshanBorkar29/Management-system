import 'package:flutter/material.dart';

class ProjectHealthSection extends StatelessWidget {
  const ProjectHealthSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectHealthItem(
        name: 'E-Commerce Platform Redesign',
        company: 'ShopNow Inc.',
        status: 'Critical',
        statusColor: Colors.red,
        healthPercent: 78,
        daysOverdue: '9d overdue',
      ),
      ProjectHealthItem(
        name: 'Mobile Banking App v2',
        company: 'TrustBank Corp.',
        status: 'At Risk',
        statusColor: Colors.orange,
        healthPercent: 35,
        daysRemaining: '36d remaining',
      ),
      ProjectHealthItem(
        name: 'HR Management System',
        company: 'Internal',
        status: 'Critical',
        statusColor: Colors.red,
        healthPercent: 40,
        daysOverdue: '37d overdue',
      ),
      ProjectHealthItem(
        name: 'AI Analytics Dashboard',
        company: 'DataViz Ltd.',
        status: 'At Risk',
        statusColor: Colors.orange,
        healthPercent: 8,
        daysRemaining: '66d remaining',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Project Health',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Good', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Risk', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Critical', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...projects.map((project) => _ProjectCard(project: project)),
        ],
      ),
    );
  }
}

class ProjectHealthItem {
  final String name;
  final String company;
  final String status;
  final Color statusColor;
  final int healthPercent;
  final String? daysOverdue;
  final String? daysRemaining;

  ProjectHealthItem({
    required this.name,
    required this.company,
    required this.status,
    required this.statusColor,
    required this.healthPercent,
    this.daysOverdue,
    this.daysRemaining,
  });
}

class _ProjectCard extends StatelessWidget {
  final ProjectHealthItem project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: project.statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        project.company,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: project.statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      project.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: project.statusColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${project.healthPercent}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: project.healthPercent / 100,
              minHeight: 5,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(project.statusColor),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            project.daysOverdue ?? project.daysRemaining ?? '',
            style: TextStyle(
              fontSize: 11,
              color: project.daysOverdue != null
                  ? Colors.red
                  : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
