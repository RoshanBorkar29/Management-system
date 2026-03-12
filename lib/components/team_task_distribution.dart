import 'package:flutter/material.dart';

class TeamTaskDistribution extends StatelessWidget {
  final List<Map<String, dynamic>> teamData;

  const TeamTaskDistribution({super.key, required this.teamData});

  @override
  Widget build(BuildContext context) {
    final teamMembers = teamData
        .map(
          (d) => TeamMemberTasks(
            name: d['name'] as String,
            done: d['done'] as int,
            active: d['active'] as int,
            todo: d['todo'] as int,
          ),
        )
        .toList();

    if (teamMembers.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('No team data yet')),
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
          const Text(
            'Team Task Distribution',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          ...teamMembers.map((member) => _TaskBar(member: member)),
          const SizedBox(height: 12),
          // legend
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC71),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Done',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Active',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Todo',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TeamMemberTasks {
  final String name;
  final int done;
  final int active;
  final int todo;

  TeamMemberTasks({
    required this.name,
    required this.done,
    required this.active,
    required this.todo,
  });

  int get total => done + active + todo;
}

class _TaskBar extends StatelessWidget {
  final TeamMemberTasks member;

  const _TaskBar({required this.member});

  @override
  Widget build(BuildContext context) {
    final totalTasks = 8; // max tasks for proportional sizing

    // wrap everything in a Tooltip so that hovering over the task bar
    // shows a little card with the counts for this member.
    return Tooltip(
      message:
          'Done: ${member.done}\nActive: ${member.active}\nTodo: ${member.todo}',
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: const TextStyle(color: Colors.black, fontSize: 12),
      preferBelow: true,
      waitDuration: const Duration(milliseconds: 200),
      showDuration: const Duration(seconds: 2),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member.name,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // Task bar - using Flexible to make it responsive
                Flexible(
                  flex: 5, // takes 5/6 of available space
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      //overflow: Overflow.hidden,
                    ),
                    child: Row(
                      children: [
                        // done (green)
                        if (member.done > 0)
                          Flexible(
                            flex: member.done,
                            child: Container(
                              height: 20,
                              color: const Color(0xFF2ECC71),
                            ),
                          ),
                        // active (blue)
                        if (member.active > 0)
                          Flexible(
                            flex: member.active,
                            child: Container(height: 20, color: Colors.blue),
                          ),
                        // todo (grey)
                        if (member.todo > 0)
                          Flexible(
                            flex: member.todo,
                            child: Container(
                              height: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        // remaining space
                        if (member.total < totalTasks)
                          Flexible(
                            flex: totalTasks - member.total,
                            child: Container(
                              height: 20,
                              color: Colors.grey[200],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Right side info - using Flexible to prevent overflow
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      member.done.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
