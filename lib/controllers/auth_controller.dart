import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/models/user.dart';
import 'package:prep_pro/ui/widgets/function_widgets.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'get_storage_controller.dart';

class AuthController extends GetxController {
  AuthController get to => Get.find();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void googleSignIn() async {
    showLoader();
    final account = await _googleSignIn.signIn();
    if (account == null) {
      //remove loader dialog if error
      Get.back();
      return;
    }
    var auth = await account.authentication;
    Map<String, dynamic> credentials = {
      "email": account.email,
      "token": auth.idToken,
    };
    final response = await DioController().to.signInGoogle(credentials);
    //remove loader dialog
    Get.back();
    if (response == null) {
      return;
    }
    final user = User.fromJson(response);
    UserController().to.user.value = user;
  }

  void appleSignIn() async {
    showLoader();
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    if (credential.email == null) {
      Get.back();
      //show email null not allowed dialog
      Get.dialog(
        CupertinoAlertDialog(
          title: const Text("Please login again and provide your email"),
          actions: [
            MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    } else {
      final credentials = {
        "token": credential.identityToken,
        "email": credential.email,
      };
      final response = await DioController().to.signInApple(credentials);
      //remove loader dialog
      Get.back();
      if (response == null) {
        return;
      }
      final user = User.fromJson(response);
      UserController().to.user.value = user;
    }
  }

  void testSignIn() async {
    showLoader();
    final response = await DioController().to.signInEmailPw();
    Get.back();
    if (response == null) {
      return;
    }
    final user = User.fromJson(response);
    UserController().to.user.value = user;
    GetStorageController().to.saveUser(user);
    UserController().to.user.value = user;
  }

  void signOut() {
    UserController().to.user.value = null;
    GetStorageController().to.deleteUserToken();
  }
}
