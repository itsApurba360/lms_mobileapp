import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/purchases_controller.dart';

class PurchasesView extends GetView<PurchasesController> {
  const PurchasesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PurchasesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PurchasesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
