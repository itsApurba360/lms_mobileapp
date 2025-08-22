import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/models/course.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 244, 244, 244),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: const Text('Courses'),
          actions: [
            _iconBtn(context, Icons.import_export, _showSortBottomSheet),
            _iconBtn(context, Icons.tune, _showFilterBottomSheet, rightPad: 10),
          ],
        ),
        body: controller.obx(
          (state) => RefreshIndicator(
            onRefresh: controller.getCourseList,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: controller.coursesList.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.COURSE_DETAILS,
                  arguments: {
                    'id': controller.coursesList[i].name,
                    'course': controller.coursesList[i]
                  },
                ),
                child: _courseCard(controller.coursesList[i]),
              ),
            ),
          ),
          onEmpty: const Center(child: Text('No courses found')),
        ),
      ),
    );
  }

  Widget _courseCard(Course course) {
    final hasDiscount =
        course.customDiscount != null && course.customDiscount! > 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 🖼️ Image with padding and rounded corners
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: controller.apiClientController.hostUrl! +
                            course.image!,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    if (hasDiscount)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${course.customDiscount!.toStringAsFixed(0)}% Off',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // 📦 Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < course.rating!.toInt()
                            ? Icons.star
                            : Icons.star_border,
                        size: 14,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(course.customCourseDuration.toString(),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      const Spacer(),
                      if (hasDiscount)
                        Text(course.coursePrice!.toStringAsFixed(0),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                      if (hasDiscount) const SizedBox(width: 6),
                      Text(
                          (controller.getCoursePrice(course)),
                          style: TextStyle(
                              fontSize: 14,
                              color: hasDiscount ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(
      BuildContext ctx, IconData icon, void Function(BuildContext) sheet,
      {double rightPad = 6}) {
    return Padding(
      padding: EdgeInsets.only(right: rightPad, left: 6),
      child: IconButton(
        onPressed: () => sheet(ctx),
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext ctx) {
    final sorts = [
      'All',
      'Newest',
      'Price: Low to High',
      'Price: High to Low',
      'Best Sellers',
      'Best Rated'
    ];
    var current = 'All';

    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sort By',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...sorts.map((o) => RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  value: o,
                  groupValue: current,
                  activeColor: Colors.green,
                  title: Text(o, style: const TextStyle(fontSize: 16)),
                  onChanged: (v) {
                    current = v!;
                  },
                )),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // TODO: handle apply logic
                      Navigator.pop(ctx);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext ctx) {
    final levels = ['Beginner', 'Intermediate', 'Expert'];
    final topics = ['Flutter', 'React', 'JavaScript', 'Python'];
    final RxList<String> selLevels = <String>[].obs;
    final RxList<String> selTopics = <String>[].obs;

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true, // important for letting it expand properly
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sort By',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _filterSection('Level', levels, selLevels),
                Divider(height: 24, color: Colors.grey.shade100),
                _filterSection('Topic', topics, selTopics),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // TODO: apply logic
                          Navigator.pop(ctx);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterSection(
      String title, List<String> items, RxList<String> selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Obx(() => Column(
              children: items
                  .map((it) => _checkTile(
                        title: it,
                        isChecked: selected.contains(it),
                        onChanged: (v) =>
                            v ? selected.add(it) : selected.remove(it),
                      ))
                  .toList(),
            )),
      ],
    );
  }

  Widget _checkTile(
      {required String title,
      required bool isChecked,
      required ValueChanged<bool> onChanged}) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          value: isChecked,
          onChanged: (v) => onChanged(v!),
          activeColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(width: 0.5)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      onTap: () => onChanged(!isChecked),
    );
  }
}
