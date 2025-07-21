import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/modules/examinstructions/views/examinstructions_view.dart';

class RightSideSheet extends StatefulWidget {
  const RightSideSheet({super.key});

  @override
  State<RightSideSheet> createState() => _RightSideSheetState();
}

class _RightSideSheetState extends State<RightSideSheet> {
  int expandedSection = 1;
  final int totalQuestions = 25;

  final Map<int, int> attemptedCounts = {
    1: 10,
    2: 17,
    3: 4,
  };

  Widget dotStatus(
    Color color,
    String text, {
    bool withBorder = false,
    IconData? icon,
    double fontSize = 12,
  }) {
    Widget leading = icon != null
        ? Icon(icon, color: color, size: 14)
        : Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: withBorder
                  ? Border.all(color: Colors.black54, width: 1)
                  : null,
            ),
          );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading,
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: fontSize)),
      ],
    );
  }

  Widget buildSection(int sectionNumber, String title) {
    bool isExpanded = expandedSection == sectionNumber;
    int attempted = attemptedCounts[sectionNumber] ?? 0;
    double progress = attempted / totalQuestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => expandedSection = sectionNumber),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          if (sectionNumber == 1 || sectionNumber == 2 || sectionNumber == 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dotStatus(Colors.red, "2", icon: Icons.star),
                dotStatus(Colors.grey, "3"),
                dotStatus(Colors.white, "5", withBorder: true),
                dotStatus(Colors.green, "$attempted"),
              ],
            ),
          if (sectionNumber == 1 || sectionNumber == 2 || sectionNumber == 3)
            const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(totalQuestions, (index) {
              int questionNo = index + 1;
              Color color;
              BoxBorder? border;
              Color textColor = Colors.white;

              if (sectionNumber == 1) {
                if (questionNo % 7 == 0) {
                  color = Colors.transparent;
                  border = Border.all(color: Colors.red, width: 2);
                  textColor = Colors.red;
                } else if (questionNo % 5 == 0) {
                  color = Colors.transparent;
                  border = Border.all(color: Colors.black54, width: 1);
                  textColor = Colors.black;
                } else if (questionNo % 3 == 0) {
                  color = Colors.green;
                } else {
                  color = Colors.grey;
                }
              } else {
                if (questionNo % 3 == 0) {
                  color = Colors.green;
                } else {
                  color = Colors.grey.shade300;
                }
              }

              return GestureDetector(
                onTap: () {
                  // TODO: Navigate to question or handle click
                  print(
                      'Tapped question $questionNo in section $sectionNumber');
                },
                child: Container(
                  width:
                      (MediaQuery.of(context).size.width * 0.8 - 32 - 6 * 4) /
                          5,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: color,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: border,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$questionNo',
                        style: TextStyle(fontSize: 12, color: textColor),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
        ],
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    final topPadding = MediaQuery.of(context).padding.top;

    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.white,
        child: Container(
          width: width,
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Exam Instructions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                const ExaminstructionsView(isFromTest: true));
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.info_outline, size: 18),
                              SizedBox(width: 6),
                              Text("View Instructions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.star,
                                          color: Colors.red, size: 16),
                                      SizedBox(width: 6),
                                      Text(
                                        "Marked for Review",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      dotStatus(Colors.grey, "Unattempted",
                                          fontSize: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      dotStatus(Colors.white, "Unseen",
                                          withBorder: true, fontSize: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      dotStatus(Colors.green, "Attempted",
                                          fontSize: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildSection(1, "Section 1"),
                        buildSection(2, "Section 2"),
                        buildSection(3, "Section 3"),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Submit action
                              print("Submit clicked");
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              "Submit Test",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
