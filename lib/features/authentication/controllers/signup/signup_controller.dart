import 'package:caferesto/features/personalization/models/user_model.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/helpers/network_manager.dart';
import 'package:caferesto/utils/popups/full_screen_loader.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../screens/signup.widgets/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  void signup() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        "Nous sommes en train de traiter  vos informations...",
        TImages.docerAnimation,
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

      /// Register user in the firebase auth & save user data in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Add explicit reload after registration
      await userCredential.user?.sendEmailVerification();

      // Show email sent confirmation
      TLoaders.successSnackBar(
          title: 'Email de Vérification Envoyé',
          message:
              'Veuillez vérifier votre boîte de réception pour le lien de confirmation.');

      /// Save authenticated user data in the firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      /// Move to verify email screen
      Get.off(() => VerifyEmailScreen(email: email.text.trim()));

      // >>> Here goes the logic to send data to backend (API or Firebase)
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap !', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
