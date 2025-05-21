import 'package:caferesto/data/repositories/authentication/authentication_repository.dart';
import 'package:caferesto/features/personalization/controllers/user_controller.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/helpers/network_manager.dart';
import 'package:caferesto/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final userController = Get.put(UserController());

  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
    super.onInit();
  }

  void emailAndPasswordSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        "Authentification en cours...",
        TImages.docerAnimation,
      );

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email and Password authentication
      final UserCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap !', message: e.toString());
    }
  }

  /// -- Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        "Authentification en cours...",
        TImages.docerAnimation,
      );

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Login user using Google authentication
      final userCredentials = await AuthenticationRepository.instance
          .signInWithGoogle();

      // Save user record in Firestore
      await userController.saveUserRecord(userCredentials);
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
        print("Google SignIn Error: $e"); // Add this

      TLoaders.errorSnackBar(title: 'Oh snap !', message: e.toString());
    }
  }
}
