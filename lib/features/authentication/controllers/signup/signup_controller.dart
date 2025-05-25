import 'package:caferesto/features/personalization/models/user_model.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/helpers/network_manager.dart';
import 'package:caferesto/utils/popups/full_screen_loader.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    TFullScreenLoader.openLoadingDialog(
      "Nous sommes en train de traiter vos informations...",
      TImages.docerAnimation,
    );

    try {
      // 1. Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Pas de connexion',
          message: 'Veuillez vérifier votre connexion internet.',
        );
        return;
      }

      // 2. Validate form
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // 3. Check privacy policy
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Politique de confidentialité',
          message: 'Veuillez accepter la politique de confidentialité.',
        );
        return;
      }

      // 4. Register with Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // 5. Ensure user is loaded
      await Future.delayed(const Duration(seconds: 1));
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception(
            "L'utilisateur n'a pas pu être chargé après l'inscription.");
      }

      // 6. Save user data to Firestore
      final newUser = UserModel(
        id: user.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // 7. Navigate to verify email screen
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Félicitations!",
        message:
            "Votre compte a été créé! Vérifiez votre email pour continuer.",
      );

      Get.off(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap !', message: e.toString());
    }
  }
}
