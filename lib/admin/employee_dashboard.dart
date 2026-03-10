import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:managementt/admin/register_employee.dart';
import 'package:managementt/admin/employee_details_page.dart';
import 'package:managementt/components/animated_gradient_container.dart';
import 'package:managementt/components/container_design.dart';
import 'package:managementt/controller/member_controller.dart';

class EmployeeDashboard extends StatelessWidget {
  EmployeeDashboard({super.key});
  final MemberController memberController = Get.put(MemberController());
  final int totalEmployeeCount = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Employee Dashboard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Get.to(() => RegisterEmployees());
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.blueGrey,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          AnimatedGradientContainer(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + kToolbarHeight + 8,
              20,
              14,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$totalEmployeeCount total employees",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 44,
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: "Search employees..",
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.white70),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (memberController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (memberController.members.isEmpty) {
                return Center(child: Text("No Members Found"));
              }

              return ListView.builder(
                itemCount: memberController.members.length,
                itemBuilder: (context, index) {
                  final member = memberController.members[index];

                  return InkWell(
                    onTap: () {
                      Get.to(() => EmployeeDetailsPage(), arguments: member);
                    },
                    child: ContainerDesign(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            member.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Text("Confirm Remove"),
                                  content: Text(
                                    "Are you sure you want to remove ${member.name} ?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (member.id != null) {
                                          memberController.removeMember(
                                            member.id!,
                                          );
                                        }
                                        Get.back();
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
