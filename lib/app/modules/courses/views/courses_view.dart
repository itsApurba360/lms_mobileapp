import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    final courseList = [
      {
        "image":
            "https://cdn.shopaccino.com/igmguru/products/flutter-igmguru_1527424732_l.jpg?v=531",
        "title": "Mastering Flutter for Beginners",
        "rating": 4,
        "duration": "4 hrs",
        "price": 60.0,
        "discounted": 36.0
      },
      {
        "image":
            "https://blogs.otpless.com/wp-content/uploads/2023/01/Screenshot-2024-11-12-at-3.11.23%E2%80%AFPM-1024x1024.png",
        "title": "Advanced React Techniques",
        "rating": 5,
        "duration": "6 hrs",
        "price": 100.0,
        "discounted": 60.0
      },
      {
        "image":
            "https://eeakolkata.com/wp-content/uploads/2023/10/python-Data-Science-Libraries-With-Implementation.webp",
        "title": "Python for Data Science",
        "rating": 3,
        "duration": "3 hrs",
        "price": 80.0,
        "discounted": null
      },
      {
        "image":
            "https://files.ably.io/ghost/prod/2023/12/choosing-the-best-javascript-frameworks-for-your-next-project.png",
        "title": "JavaScript Crash Course",
        "rating": 4,
        "duration": "2 hrs",
        "price": 50.0,
        "discounted": 30.0
      },
      {
        "image":
            "https://codingbytes.com/wp-content/uploads/2022/03/full-stack-web-development.jpg",
        "title": "Fullstack Web Dev Bootcamp",
        "rating": 5,
        "duration": "8 hrs",
        "price": 120.0,
        "discounted": 72.0
      },
      {
        "image":
            "https://cdn.mos.cms.futurecdn.net/v2/t:0,l:0,cw:6499,ch:3656,q:80,w:6499/pL5rBKGq88cnoqgdJgCXGS.jpg",
        "title": "Cloud Computing Essentials",
        "rating": 4,
        "duration": "5 hrs",
        "price": 90.0,
        "discounted": null
      },
    ];

    return Container(
      color: const Color(0xFFF5F5F5),
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
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: courseList.length,
          itemBuilder: (_, i) => _courseCard(courseList[i]),
        ),
      ),
    );
  }

  Widget _courseCard(Map<String, dynamic> course) {
    final hasDiscount = course["discounted"] != null;

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
                      child: Image.network(
                        course["image"],
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
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
                          child: const Text('40% Off',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
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
                    course["title"],
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
                        i < course["rating"] ? Icons.star : Icons.star_border,
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
                      Text(course["duration"],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      const Spacer(),
                      if (hasDiscount)
                        Text('\$${course["price"].toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                      if (hasDiscount) const SizedBox(width: 6),
                      Text(
                          '\$${(course["discounted"] ?? course["price"]).toStringAsFixed(2)}',
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
