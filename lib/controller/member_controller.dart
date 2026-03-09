import 'package:get/get.dart';
import 'package:managementt/model/member.dart';
import 'package:managementt/service/member_service.dart';

class MemberController extends GetxController {
  final MemberService _memberService = MemberService();
  var members = <Member>[].obs;
  var filteredMembers = <Member>[].obs;
  var owner = Rxn<Member>();
  var isLoading = false.obs;
  var tasks = <String>[].obs;
  @override
  void onInit() {
    getMembers();
    super.onInit();

    void searchMember(String searchQuery) {
      if (searchQuery.isEmpty) {
        filteredMembers.assignAll(members);
      } else {
        filteredMembers.assignAll(
          members.where(
            (member) =>
                member.name.toLowerCase().contains(searchQuery.toLowerCase()),
          ),
        );
      }
    }
  }

  Future<void> addMember(Member member) async {
    isLoading.value = true;
    try {
      await _memberService.addMember(member);
      await getMembers();
      Get.back();
      Get.snackbar('Success', 'Employee added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add member: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMembers() async {
    isLoading.value = true;
    try {
      members.value = await _memberService.getMembers();
    } catch (e) {
      print('MemberController: Failed to fetch members — $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeMember(String id) async {
    try {
      await _memberService.removeMember(id);
      await getMembers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove member: $e');
    }
  }

  Future<void> getMemberById(String id) async {
    try {
      isLoading.value = true;
      owner.value = await _memberService.getMemberById(id);
    } catch (e) {
      owner.value = null;
      Future.microtask(() {
        Get.snackbar("Error", e.toString());
      });
    } finally {
      isLoading.value = false;
    }
  }
}
