import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/result_controller.dart';

class Solutions extends StatelessWidget {
  const Solutions({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Report Question',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Divider(thickness: 1),
                  ...List.generate(reportOptions.length, (index) {
                    return RadioListTile<int>(
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
                    );
                  }),
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResultController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            final currentSection =
                controller.sections[controller.currentSectionIndex.value];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Pills
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.sections.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final isSelected =
                            controller.currentSectionIndex.value == index;
                        return GestureDetector(
                          onTap: () =>
                              controller.currentSectionIndex.value = index,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller.sections[index].title,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Results Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 8),

                  ...currentSection.questions.asMap().entries.map((entry) {
                    final qIndex = entry.key;
                    final question = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question number + report button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Question ${qIndex + 1}",
                                style: const TextStyle(fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.warning_amber,
                                  color: Colors.orange),
                              onPressed: () => _openWarningSheet(context),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Question text
                        Text(
                          question.questionText,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 12),

                        // Options
                        ...List.generate(question.options.length, (optIndex) {
                          final isCorrect = optIndex == question.correctIndex;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? Colors.green.shade50
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isCorrect
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${optIndex + 1}. ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect
                                        ? Colors.green.shade800
                                        : Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    question.options[optIndex],
                                    style: TextStyle(
                                      fontWeight: isCorrect
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isCorrect
                                          ? Colors.green.shade800
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 10),

                        // Rational + optional Watch Video button
                        // Rational + optional Watch Video
                        if (question.rationalText.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Rational",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              if (question.videoUrl.isNotEmpty)
                                TextButton.icon(
                                  onPressed: () {
                                    // No action for now
                                  },
                                  icon: const Icon(Icons.play_circle_fill,
                                      color: Colors.green),
                                  label: const Text(
                                    "Watch Video",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(question.rationalText),
                          ),
                        ],

                        const Divider(thickness: 1),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
