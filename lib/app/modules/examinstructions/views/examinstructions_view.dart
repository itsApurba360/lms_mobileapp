import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/examinstructions_controller.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class ExaminstructionsView extends StatefulWidget {
  const ExaminstructionsView({super.key});

  @override
  State<ExaminstructionsView> createState() => _ExaminstructionsViewState();
}

class _ExaminstructionsViewState extends State<ExaminstructionsView> {
  String? selectedLanguage;

  final ExaminstructionsController controller =
      Get.put(ExaminstructionsController());

  void onContinue() {
    if (selectedLanguage == null) {
      Get.snackbar(
        "Language Required",
        "Please select a language to continue.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } else {
      Get.toNamed('/exam');
    }
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Choose Language",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1, thickness: 1), // Full-width divider
            ...controller.languages.asMap().entries.map((entry) {
              final int index = entry.key;
              final String lang = entry.value;
              return Column(
                children: [
                  RadioListTile<String>(
                    title: Text(lang),
                    value: lang,
                    groupValue: selectedLanguage,
                    activeColor: Colors.green, // ✅ Green selected radio
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  if (index < controller.languages.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        height: 1,
                        thickness: 0.7,
                        color: Colors.grey.shade300, // ✅ Light + not full width
                      ),
                    ),
                ],
              );
            }),
            const SizedBox(height: 10),
          ],
        );
      },
    );
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

              // Language Selection Field with arrow
              InkWell(
                onTap: () => _showLanguageSheet(context),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedLanguage ?? "Select Language",
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedLanguage == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Agree and Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
