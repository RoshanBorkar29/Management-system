import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managementt/controller/admin_nav_controller.dart';

class MemberProfilePage extends StatefulWidget {
  const MemberProfilePage({super.key});

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage>
    with SingleTickerProviderStateMixin {
  bool _showProjects = false;
  bool _isLoadingProjects = false;
  List<_ProjectItem> _loadedProjects = const [];

  Future<void> _loadProjectsIfNeeded() async {
    if (_loadedProjects.isNotEmpty || _isLoadingProjects) return;
    setState(() => _isLoadingProjects = true);
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() {
      _loadedProjects = const [
        _ProjectItem(
          title: 'E-Commerce Platform Redesign',
          company: 'ShopNow Inc.',
          progress: 0.78,
          progressText: '78%',
          taskSummary: '1/2 tasks completed',
          dueText: '9d over',
          accent: Color(0xFF2F59F7),
          dueColor: Color(0xFFFF4D57),
        ),
        _ProjectItem(
          title: 'Mobile Banking App v2',
          company: 'TrustBank Corp.',
          progress: 0.35,
          progressText: '35%',
          taskSummary: '1/3 tasks completed',
          dueText: '36d left',
          accent: Color(0xFF0FA885),
          dueColor: Color(0xFF10B981),
        ),
        _ProjectItem(
          title: 'AI Analytics Dashboard',
          company: 'DataViz Ltd.',
          progress: 0.08,
          progressText: '8%',
          taskSummary: '0/1 tasks completed',
          dueText: '66d left',
          accent: Color(0xFF8B5CF6),
          dueColor: Color(0xFF8B5CF6),
        ),
      ];
      _isLoadingProjects = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = <_TaskItem>[
      const _TaskItem(
        title: 'UI Component Library Setup',
        project: 'E-Commerce Platform Redesign',
        status: 'Done',
        due: 'Dec 20',
        accent: Color(0xFFE91E63),
        statusColor: Color(0xFF22C55E),
        isCompleted: true,
      ),
      const _TaskItem(
        title: 'Checkout Flow Optimization',
        project: 'E-Commerce Platform Redesign',
        status: 'In Progress',
        due: '14d overdue',
        accent: Color(0xFFFFD54F),
        statusColor: Color(0xFF3B82F6),
      ),
      const _TaskItem(
        title: 'Leave Management Module',
        project: 'HR Management System',
        status: 'Done',
        due: 'Dec 15',
        accent: Color(0xFFE91E63),
        statusColor: Color(0xFF22C55E),
        isCompleted: true,
      ),
      const _TaskItem(
        title: 'ML Model Integration',
        project: 'AI Analytics Dashboard',
        status: 'To Do',
        due: 'Apr 1',
        accent: Color(0xFFE91E63),
        statusColor: Color(0xFF9CA3AF),
      ),
    ];

    final topPad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ─── Header ───
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, topPad + 12, 16, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6D70F6), Color(0xFF8986F8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back + settings row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final nav = Get.find<AdminNavController>();
                          nav.changePage(0);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.more_horiz_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Avatar + name row
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'SC',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sarah Chen',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Senior Developer',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Engineering',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Stat pills
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          count: '4',
                          label: 'Total',
                          icon: Icons.assignment_rounded,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _StatCard(
                          count: '2',
                          label: 'Active',
                          icon: Icons.play_circle_outline_rounded,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _StatCard(
                          count: '2',
                          label: 'Done',
                          icon: Icons.task_alt_rounded,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _StatCard(
                          count: '1',
                          label: 'Overdue',
                          icon: Icons.warning_amber_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ─── Contact info card ───
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const _InfoRow(
                    icon: Icons.email_outlined,
                    text: 'sarah.chen@company.com',
                    iconColor: Color(0xFF6366F1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.grey.withValues(alpha: 0.15),
                      height: 1,
                    ),
                  ),
                  const _InfoRow(
                    icon: Icons.phone_outlined,
                    text: '1 (555) 234 5678',
                    iconColor: Color(0xFF6366F1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.grey.withValues(alpha: 0.15),
                      height: 1,
                    ),
                  ),
                  const _InfoRow(
                    icon: Icons.calendar_month_outlined,
                    text: 'Joined March 15, 2023',
                    iconColor: Color(0xFF9CA3AF),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ─── Completion rate card ───
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B5BFD).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.pie_chart_rounded,
                          size: 18,
                          color: Color(0xFF3B5BFD),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Task Completion Rate',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withValues(alpha: 0.85),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '50%',
                        style: TextStyle(
                          color: Color(0xFF3B5BFD),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 6,
                      backgroundColor: Color(0xFFEEF0F8),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF3B5BFD),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ─── Tabs + content ───
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Tab bar
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _showProjects = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: !_showProjects
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: !_showProjects
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.06,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  'Tasks (4)',
                                  style: TextStyle(
                                    color: !_showProjects
                                        ? const Color(0xFF3B5BFD)
                                        : const Color(0xFF9CA3AF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              setState(() => _showProjects = true);
                              await _loadProjectsIfNeeded();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _showProjects
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: _showProjects
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.06,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  'Projects (3)',
                                  style: TextStyle(
                                    color: _showProjects
                                        ? const Color(0xFF3B5BFD)
                                        : const Color(0xFF9CA3AF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Content
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _showProjects
                        ? _isLoadingProjects
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Color(0xFF6366F1),
                                  ),
                                )
                              : Column(
                                  key: const ValueKey('projects'),
                                  children: _loadedProjects
                                      .map((p) => _ProjectMiniCard(item: p))
                                      .toList(),
                                )
                        : Column(
                            key: const ValueKey('tasks'),
                            children: tasks
                                .map((t) => _TaskCard(item: t))
                                .toList(),
                          ),
                  ),
                ],
              ),
            ),
            // bottom padding for nav bar
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ─── Supporting widgets ───

class _StatCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.count,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 16),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskItem {
  final String title;
  final String project;
  final String status;
  final String due;
  final Color accent;
  final Color statusColor;
  final bool isCompleted;

  const _TaskItem({
    required this.title,
    required this.project,
    required this.status,
    required this.due,
    required this.accent,
    required this.statusColor,
    this.isCompleted = false,
  });
}

class _TaskCard extends StatelessWidget {
  final _TaskItem item;

  const _TaskCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          // Top accent bar
          Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [item.accent, item.accent.withValues(alpha: 0.3)],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: item.statusColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.isCompleted
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: item.statusColor,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                        decoration: item.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: const Color(0xFF9CA3AF),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.project,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: item.statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(
                    color: item.statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.schedule_rounded,
                size: 13,
                color: item.due.contains('overdue')
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 4),
              Text(
                item.due,
                style: TextStyle(
                  color: item.due.contains('overdue')
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectItem {
  final String title;
  final String company;
  final double progress;
  final String progressText;
  final String taskSummary;
  final String dueText;
  final Color accent;
  final Color dueColor;

  const _ProjectItem({
    required this.title,
    required this.company,
    required this.progress,
    required this.progressText,
    required this.taskSummary,
    required this.dueText,
    required this.accent,
    required this.dueColor,
  });
}

class _ProjectMiniCard extends StatelessWidget {
  final _ProjectItem item;

  const _ProjectMiniCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [item.accent, item.accent.withValues(alpha: 0.3)],
              ),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.company,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: item.dueColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.dueText,
                  style: TextStyle(
                    color: item.dueColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: item.progress,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: AlwaysStoppedAnimation<Color>(item.accent),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                item.progressText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: item.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.taskSummary,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
