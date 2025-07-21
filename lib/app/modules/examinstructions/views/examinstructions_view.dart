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

  final List<String> instructions = [
    "The test contains 25 total questions.",
    "Each question has 4 options out of which only one is correct.",
    "You have to finish the test in 20 minutes.",
    "You will be awarded 2 mark for each correct answer and 0.5 will be deducted for each wrong answer.",
    "There is no negative marking for the questions that you have not attempted.",
    "I have read all the instructions carefully and have understood them. I agree not to cheat or use unfair means in this examination. "
        "I understand that using unfair means of any sort for my own or someone else’s advantage will lead to my immediate disqualification. "
        "The decision of Testbook.com will be final in these matters and cannot be appealed.",
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExaminstructionsView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI - Generated Quantitative Aptitude\nSectional Test - 01',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    "Duration: 20 Mins.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    "Maximum Marks: 50.0",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...instructions.map((item) {
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
              }).toList(),
              const SizedBox(height: 20),

              // ✅ Dropdown with proper popup alignment
              DropdownButtonHideUnderline(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text(
                        "Select Language",
                        style: TextStyle(fontSize: 16),
                      ),
                      value: selectedLanguage,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLanguage = newValue;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "English",
                          child: Text(
                            "English",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Hindi",
                          child: Text(
                            "Hindi",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Marathi",
                          child: Text(
                            "Marathi",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
