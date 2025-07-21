import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/examinstructions_controller.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class ExaminstructionsView extends StatefulWidget {
  final bool isFromTest;

  const ExaminstructionsView({super.key, this.isFromTest = false});

  @override
  State<ExaminstructionsView> createState() => _ExaminstructionsViewState();
}

class _ExaminstructionsViewState extends State<ExaminstructionsView> {
  final ExaminstructionsController controller =
      Get.put(ExaminstructionsController());

  void onContinue() {
    Get.toNamed('/mcq');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('ExaminstructionsView'),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.examTitle.value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Duration: ${controller.duration.value}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    "Maximum Marks: ${controller.maxMarks.value}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Dynamic Instructions
              ...controller.instructions.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(fontSize: 16)),
                      Expanded(child: Text(item)),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Removed Language Selection Field

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.isFromTest) {
                      Get.back();
                    } else {
                      onContinue();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(widget.isFromTest
                      ? "Back to Test"
                      : "Agree and Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
