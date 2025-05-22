import 'package:caferesto/features/authentication/screens/password-config/reset_password.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/helpers/network_manager.dart';
import 'package:caferesto/utils/popups/full_screen_loader.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> ForgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  Future<void> sendPasswordResetEmail() async {
    if (ForgetPasswordFormKey.currentState!.validate()) {
      try {
        // Start loading
        TFullScreenLoader.openLoadingDialog(
            'Processing your request...', TImages.docerAnimation);

        // Check internet connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

        // Form Validation
        if (!ForgetPasswordFormKey.currentState!.validate()) {
          TFullScreenLoader.stopLoading();
          return;
        }

        await AuthenticationRepository.instance
            .sendPasswordResetEmail(email.text.trim());


        // Stop loading
        TFullScreenLoader.stopLoading();
        // Show success message
        TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link sent to Reset your Password'.tr);

        // Redirect
        Get.to(() => ResetPassword(email: email.text.trim()));
      } catch (e) {
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
            title: 'Oh Snap !',
            message: e.toString(),
          );
        }
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Please enter a valid email address'.tr,
        );
      }
    }

    resendPasswordResetEmail(String email) async {
      if (ForgetPasswordFormKey.currentState!.validate()) {
      try {
        // Start loading
        TFullScreenLoader.openLoadingDialog(
            'Processing your request...', TImages.docerAnimation);

        // Check internet connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

            await AuthenticationRepository.instance
            .sendPasswordResetEmail(email);


        // Stop loading
        TFullScreenLoader.stopLoading();
        // Show success message
        TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link sent to Reset your Password'.tr);

      } catch (e) {
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
            title: 'Oh Snap !',
            message: e.toString(),
          );
        }
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Please enter a valid email address'.tr,
        );
      }
    }
  }

