import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/ui/widgets/dialogs/confirmed_payment.dart';
import 'package:prep_pro/ui/widgets/dialogs/confirming_payment.dart';
import 'package:prep_pro/utils/strings.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'log_controller.dart';

class RzpController extends GetxController {
  final Razorpay _razorpay = Razorpay();
  final _dio = DioController().to;
  RxBool buying = false.obs;
  Rxn<dynamic> buyingMedia = Rxn<dynamic>();

  RxBool confirmingPayment = false.obs;
  RxBool paymentDone = false.obs;
  // final AnalyticsController analytics = Get.find();
  RxInt paymentId = RxInt(0);
  // Rxn<AddressModel> deliveryAddress = Rxn<AddressModel>();

  @override
  void onReady() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onReady();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.back();
    confirmingPayment.value = true;
    paymentDone.value = true;
    Get.dialog(
      const PopScope(
        canPop: false,
        child: ConfirmingPaymentDialog(),
      ),
      barrierDismissible: false,
    );
    _checkPaymentStatus(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Error",
      "Payment cancelled, please try again",
      backgroundColor: Colors.red,
    );
    confirmingPayment.value = false;
    _dio.delete("${Endpoints.payment}/${paymentId.value}");
    buyingMedia.value = null;
    buying.value = false;
    dLog(
      "URL: 'rzp payment Error'"
      "\nName:handlePaymentError \nPARAMS:"
      "paymentId=${paymentId.value}"
      "\nDETAILS:"
      "${response.message}",
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    // print("External wallet selected");
    // print(response.walletName);
  }

  Future<void> _checkPaymentStatus(
      PaymentSuccessResponse paymentResponse) async {
    try {
      log("Payment Status: Checking...");

      var url = Endpoints.paymentVerify;
      var response = await _dio.post(url, {
        "rzp_payment_id": paymentResponse.paymentId,
        // "payable_id": buyingMedia.value.id,
        "payment_id": paymentId.value,
      });
      if (response.statusCode == 200) {
        var data = (response.data);
        var paid = data['paid'];
        if (paid == true) {
          log("Payment Status: Confirmed");
          buying.value = false;
          confirmingPayment.value = false;
          Get.back();
          Get.dialog(
            const ConfirmedPaymentDialog(),
            barrierDismissible: true,
          );
          Timer(const Duration(milliseconds: 1500), () {
            Get.back();
          });
        } else {
          Timer(const Duration(seconds: 2), () {
            _checkPaymentStatus(paymentResponse);
          });
        }
      } else {
        dLog(
          "URL: 'payment/verify'"
          "Name:checkPaymentStatus \nPARAMS:"
          "darbu_payment_id=${paymentId.value},rzp_payment_id=${paymentResponse.paymentId}"
          "\nDETAILS:"
          "${response.data}",
        );
        log('Error checking payment status', error: response.body);
      }
    } catch (e) {
      dLog(
        "URL: 'payment/verify'"
        "Name:checkPaymentStatus \nPARAMS:"
        "darbu_payment_id=${paymentId.value},rzp_payment_id=${paymentResponse.paymentId}"
        "\nDETAILS:"
        "$e",
      );
      log("Checking error-> $e");
    }
  }
}
