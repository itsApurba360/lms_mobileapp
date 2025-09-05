import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';

class AddressFormController extends GetxController {
  final apiClientController = Get.find<ApiClientController>();
  final formKey = GlobalKey<FormState>();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodeController = TextEditingController();
  final emailIdController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> submitAddress() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      final response = await apiClientController.post(
        '/api/method/lms_360ithub.api.save_address',
        data: {
          "address": {
            'address_line1': addressLine1Controller.text,
            'address_line2': addressLine2Controller.text,
            'city': cityController.text,
            'state': stateController.text,
            'country': countryController.text,
            'pincode': pincodeController.text,
            'email_id': emailIdController.text,
            'phone': phoneController.text,
          }
        },
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('Success', 'Address saved successfully',
            colorText: Colors.white,
            backgroundColor: Theme.of(Get.context!).colorScheme.primary);
      }
    } catch (e) {
      log(e.toString(), name: 'submitAddressError');
    }
  }
}
