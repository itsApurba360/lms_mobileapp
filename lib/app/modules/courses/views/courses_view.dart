import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: const Text('Courses'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.import_export, size: 20),
              ),
              onPressed: () => _showSortBottomSheet(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.tune, size: 20),
              ),
              onPressed: () => _showFilterBottomSheet(context),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'CoursesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final List<String> sortOptions = [
      'All',
      'Newest',
      'Price: Low to High',
      'Price: High to Low',
      'Best Sellers',
      'Best Rated',
    ];
    String selected = 'All';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text('Sort By',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              ...sortOptions.map((option) {
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  title: Text(option,
                      style: const TextStyle(fontSize: 16, height: 1.1)),
                  value: option,
                  groupValue: selected,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    selected = value!;
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Apply',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final List<String> levels = ['Beginner', 'Intermediate', 'Expert'];
    final List<String> topics = ['Flutter', 'React', 'JavaScript', 'Python'];
    final RxList<String> selectedLevels = <String>[].obs;
    final RxList<String> selectedTopics = <String>[].obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text('Filter',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Level',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 4),
              Obx(() => Column(
                    children: levels
                        .map((level) => _buildCheckboxTile(
                              title: level,
                              isChecked: selectedLevels.contains(level),
                              onChanged: (val) {
                                if (val) {
                                  selectedLevels.add(level);
                                } else {
                                  selectedLevels.remove(level);
                                }
                              },
                            ))
                        .toList(),
                  )),
              Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.grey.shade100), // lighter divider
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Topic',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 4),
              Obx(() => Column(
                    children: topics
                        .map((topic) => _buildCheckboxTile(
                              title: topic,
                              isChecked: selectedTopics.contains(topic),
                              onChanged: (val) {
                                if (val) {
                                  selectedTopics.add(topic);
                                } else {
                                  selectedTopics.remove(topic);
                                }
                              },
                            ))
                        .toList(),
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Apply',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool isChecked,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: isChecked,
            onChanged: (val) => onChanged(val!),
            activeColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(width: 0.5),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        onTap: () => onChanged(!isChecked),
      ),
    );
  }
}
