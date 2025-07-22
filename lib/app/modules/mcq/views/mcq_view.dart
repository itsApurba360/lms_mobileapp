import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/mcq_controller.dart';
import '../widgets/right_side_sheet.dart';
import '../../result/views/result_view.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class McqView extends GetView<McqController> {
  const McqView({super.key});

  void _openMenuSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const RightSideSheet(),
      transitionBuilder: (_, anim, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(anim);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  void _openWarningSheet(BuildContext context) {
    final List<String> reportOptions = ['Wrong Question', 'Out of Syllabus'];
    final RxInt selectedOption = (-1).obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Report Question',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Divider(thickness: 1),
                  ...List.generate(reportOptions.length, (index) {
                    return Column(
                      children: [
                        RadioListTile<int>(
                          value: index,
                          groupValue: selectedOption.value,
                          onChanged: (value) {
                            selectedOption.value = value!;
                            Navigator.pop(context);
                            Get.snackbar("Reported", reportOptions[index],
                                backgroundColor: Colors.green.shade100,
                                colorText: Colors.black);
                          },
                          title: Text(reportOptions[index],
                              style: const TextStyle(fontSize: 16)),
                          activeColor: Colors.green,
                          dense: true,
                        ),
                        if (index != reportOptions.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child:
                                Divider(color: Colors.grey[300], endIndent: 16),
                          ),
                      ],
                    );
                  }),
                ],
              )),
        );
      },
    );
  }

  void _showSubmitConfirmation(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Submit Section 1?"),
        content: const Text("Are you sure you want to submit this section?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<McqController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Obx(() => SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      value: controller.timerProgress.value,
                      strokeWidth: 4,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          controller.timerProgress.value > 0.1
                              ? Colors.green
                              : Colors.red),
                    ),
                  )),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.timeRemaining.value,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(controller.testName.value,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis),
                      ],
                    )),
              ),
              Obx(() => Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.warning_amber_outlined),
                        onPressed: () => _openWarningSheet(context),
                      ),
                      IconButton(
                        icon: Icon(
                          controller.isWishlisted.value
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: controller.isWishlisted.value
                              ? Colors.green
                              : Colors.black,
                        ),
                        onPressed: controller.toggleWishlist,
                      ),
                      IconButton(
                        icon: Icon(
                          controller.isStarred.value
                              ? Icons.star
                              : Icons.star_border,
                          color: controller.isStarred.value
                              ? Colors.red
                              : Colors.black,
                        ),
                        onPressed: controller.toggleStarred,
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => _openMenuSheet(context),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green,
                            child: Text('${controller.currentQno.value}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                              width: 1,
                              height: 20,
                              color: Colors.grey.shade400),
                          const SizedBox(width: 6),
                          const Icon(Icons.access_time, size: 18),
                          const SizedBox(width: 4),
                          Text(controller.elapsedTime.value,
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Chip(
                          label: Text('+2'),
                          backgroundColor: Color(0xFFDFF5DD),
                          labelStyle: TextStyle(color: Colors.green),
                        ),
                        SizedBox(width: 8),
                        Chip(
                          label: Text('-0.5'),
                          backgroundColor: Color(0xFFFBDDDD),
                          labelStyle: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.question.value,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: List.generate(controller.options.length, (index) {
                    final isSelected = controller.selectedOption.value == index;
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        controller.selectedOption.value =
                            isSelected ? -1 : index;
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.green.shade50 : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? Colors.green
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text('${index + 1}.',
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(controller.options[index],
                                  style: const TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const Spacer(),
              ],
            ),
          )),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.zero,
        child: Obx(() => Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: Colors.white,
              child: Row(
                children: [
                  controller.currentQno.value > 1
                      ? OutlinedButton(
                          onPressed: controller.goToPreviousQuestion,
                          style: OutlinedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                          ),
                          child:
                              const Icon(Icons.arrow_back, color: Colors.black),
                        )
                      : const SizedBox(width: 48),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: OutlinedButton(
                        onPressed: () {
                          _showSubmitConfirmation(context, () {
                            controller.submitTest();
                            Get.off(() => const ResultView());
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Submit Section 1',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                  if (!controller.isLastQuestion.value)
                    OutlinedButton(
                      onPressed: controller.saveNextDisabled.value
                          ? null
                          : controller.saveAndNext,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Save & Next',
                          style: TextStyle(color: Colors.black)),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
