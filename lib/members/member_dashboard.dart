import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managementt/components/animated_gradient_container.dart';
import 'package:managementt/components/app_colors.dart';
import 'package:managementt/components/section_header.dart';
import 'package:managementt/components/stat_card.dart';
import 'package:managementt/controller/dashboard_controller.dart';
import 'package:managementt/controller/profile_controller.dart';

class MemberDashboard extends StatelessWidget {
  const MemberDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dc = Get.find<DashboardController>();
    final pc = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.primary),
      body: SafeArea(
        child: Obx(() {
          if (pc.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                AnimatedGradientContainer(
                  height: 220,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome back,",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        pc.memberName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        dc.formattedDate,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              icon: Icons.folder_open,
                              count: '${pc.memberProjects.length}',
                              label: 'Projects',
                              iconColor: const Color(0xFFF3B200),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatCard(
                              icon: Icons.edit_note,
                              count: '${pc.activeTasks}',
                              label: 'Active',
                              iconColor: const Color(0xFF60A5FA),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatCard(
                              icon: Icons.task_alt,
                              count: '${pc.totalTasks}',
                              label: 'Tasks',
                              iconColor: const Color(0xFF4ADE80),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatCard(
                              icon: Icons.warning_amber_rounded,
                              count: '${pc.overdueTasks}',
                              label: 'Overdue',
                              iconColor: const Color(0xFFFACC15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Task completion overview
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    color: Colors.white,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Task Completion',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progress',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                pc.completionPercent,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: pc.completionRate,
                              minHeight: 6,
                              backgroundColor: const Color(0xFFEEF0F8),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SectionHeader(
                  title: 'Active Tasks',
                  actionText: 'See all',
                ),
                // Show actual active tasks
                if (pc.memberTasks.isNotEmpty)
                  ...pc.memberTasks
                      .where((t) => t.status != 'DONE')
                      .take(3)
                      .map(
                        (t) => ListTile(
                          leading: Icon(
                            Icons.task_alt,
                            color: t.status == 'OVERDUE'
                                ? AppColors.error
                                : AppColors.info,
                          ),
                          title: Text(t.title),
                          subtitle: Text(
                            t.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            t.status ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              color: t.status == 'OVERDUE'
                                  ? AppColors.error
                                  : AppColors.success,
                            ),
                          ),
                        ),
                      ),
                if (pc.memberTasks.where((t) => t.status != 'DONE').isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'No active tasks',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                const SectionHeader(
                  title: 'Upcoming Deadlines',
                  actionText: 'See all',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
