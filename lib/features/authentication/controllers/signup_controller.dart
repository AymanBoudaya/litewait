import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/helpers/network_manager.dart';
import 'package:caferesto/utils/popups/full_screen_loader.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastname = TextEditingController();
  final firstname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
//signup
  Future<void> signup() async {
    try {
      // Start loading
      print("Tentative d'inscription...");
      TFullScreenLoader.openLoadingDialog(
        "We are processing your information",
        TImages.animalIcon,
      );

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Validate form
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      // Check privacy policy
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'You must read and accept the privacy policy.',
        );
        return;
      }

      // >>> Here goes the logic to send data to backend (API or Firebase)
      print("All validations passed. Ready to register user.");
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap !', message: e.toString());
      print("Erreur lors de l'inscription : $e");
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
