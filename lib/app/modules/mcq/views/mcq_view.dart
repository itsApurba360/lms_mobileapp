import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mcq_controller.dart';
import '../widgets/right_side_sheet.dart'; // import the sheet component

class McqView extends GetView<McqController> {
  const McqView({super.key});

  void _openMenuSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      barrierColor: Colors.black.withOpacity(0.5), // Overlay
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const RightSideSheet();
      },
      transitionBuilder: (_, anim, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(anim);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Obx(() => Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          value: controller.timerProgress.value,
                          strokeWidth: 4,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            controller.timerProgress.value > 0.1
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.timeRemaining.value,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          controller.testName.value,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _openMenuSheet(context),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'McqView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
