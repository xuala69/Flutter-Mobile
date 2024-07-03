import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/models/test.dart';
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
    log("Payment success _handlePaymentSuccess");
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
      log("Payment success _checkPaymentStatus");

      var url = "${Endpoints.paymentVerify}${paymentId.value}/confirm";
      var response = await _dio.post(url, {
        "rzp_payment_id": paymentResponse.paymentId,
        // "payable_id": buyingMedia.value.id,
        "payment_id": paymentId.value,
      });
      if (response.data != null) {
        var data = (response);
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
          UserController().to.refreshUserData();
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

  Future<void> buyCourse(Course course, Map<String, dynamic> rzpData) async {
    try {
      buying.value = true;
      buyingMedia.value = course;

      // analytics.logEvent(
      //   eventName: "button_click",
      //   eventType: "buy_media_audio",
      //   eventLocation: "audio_screen",
      //   eventItemId: audio.id.toString(),
      // );
      paymentId.value = rzpData['notes']['payment_id'];

      _razorpay.open(rzpData);
    } catch (e) {
      // dLog(
      //   // "URL: 'audio/purchase'"
      //   // "\nName:buyAudio \nPARAMS:"
      //   // "audio_id=${audio.id},custom_price=$customPrice"
      //   // "\nDETAILS:"
      //   // "$e",
      // );
      log("buyCourse$e");
    }
  }

  Future<void> buyContent(Content content, Map<String, dynamic> rzpData) async {
    try {
      buying.value = true;
      buyingMedia.value = content;

      // analytics.logEvent(
      //   eventName: "button_click",
      //   eventType: "buy_media_audio",
      //   eventLocation: "audio_screen",
      //   eventItemId: audio.id.toString(),
      // );
      paymentId.value = rzpData['notes']['payment_id'];
      _razorpay.open(rzpData);
    } catch (e) {
      // dLog(
      //   // "URL: 'audio/purchase'"
      //   // "\nName:buyAudio \nPARAMS:"
      //   // "audio_id=${audio.id},custom_price=$customPrice"
      //   // "\nDETAILS:"
      //   // "$e",
      // );
      log("buyContent$e");
    }
  }

  Future<void> buyTest(Test test, Map<String, dynamic> rzpData) async {
    try {
      buying.value = true;
      buyingMedia.value = test;

      // analytics.logEvent(
      //   eventName: "button_click",
      //   eventType: "buy_media_audio",
      //   eventLocation: "audio_screen",
      //   eventItemId: audio.id.toString(),
      // );
      paymentId.value = rzpData['notes']['payment_id'];
      _razorpay.open(rzpData);
    } catch (e) {
      // dLog(
      //   // "URL: 'audio/purchase'"
      //   // "\nName:buyAudio \nPARAMS:"
      //   // "audio_id=${audio.id},custom_price=$customPrice"
      //   // "\nDETAILS:"
      //   // "$e",
      // );
      log("buyCourse$e");
    }
  }
}
