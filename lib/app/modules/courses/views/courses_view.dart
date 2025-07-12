import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoursesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoursesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
