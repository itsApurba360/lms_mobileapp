import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/models/razorpay.dart';
import 'package:lms_app/app/modules/course_details/controllers/course_details_controller.dart';
import 'package:lms_app/app/modules/courses/controllers/courses_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayController extends GetxController {
  final _razorpay = Razorpay().obs;
  final _razorpayModel = RazorpayModel().obs;
  final _apiClientController = Get.find<ApiClientController>();
  final _courseDetailsController = Get.find<CourseDetailsController>();
  final _coursesController = Get.find<CoursesController>();

  @override
  void onInit() {
    super.onInit();
    _razorpay.value.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.value.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.value.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await _apiClientController.post(
      '/api/method/lms_360ithub.api.payment_success',
      data: {
        'integration_request': _razorpayModel.value.integrationRequest!,
        'params': response.data,
      },
    );
    _courseDetailsController.onInit();
    _coursesController.onInit();
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    Get.snackbar('Error', 'Payment Failed',
        backgroundColor: Theme.of(Get.context!).colorScheme.primary,
        colorText: Theme.of(Get.context!).colorScheme.onPrimary);
    await _apiClientController.post(
      '/api/method/lms_360ithub.api.payment_failure',
      data: {
        'integration_request': _razorpayModel.value.integrationRequest!,
        'params': response.error,
      },
    );
  }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   log(response.toString(), name: 'ExternalWalletResponse');
  // }

  Future<void> startPayment(RazorpayModel razorpay) async {
    _razorpayModel.value = razorpay;

    final options = {
      'key': _razorpayModel.value.razorpayKey!,
      'amount': _razorpayModel.value.amount!,
      'name': _razorpayModel.value.title!,
      'description': _razorpayModel.value.description!,
      'order_id': _razorpayModel.value.orderId!,
    };

    _razorpay.value.open(options);
  }
}
