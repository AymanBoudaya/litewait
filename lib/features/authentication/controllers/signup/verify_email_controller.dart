import 'dart:async';

import 'package:caferesto/common/widgets/success_screen/success_screen.dart';
import 'package:caferesto/data/repositories/authentication/authentication_repository.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/text_strings.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../screens/login/login.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  Timer? _timer; // Add timer reference
  /// Send email whenever verify screen appears & set timer for autoredirect
  @override
  void onReady() {
    setTimerForAutoRedirect();
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Clean up timer
    super.onClose();
  }

  /// Send email verification link
  resendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null || !user!.emailVerified)
        await user.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email Renvoyé',
          message: 'Nouvel email de vérification envoyé!');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap !', message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email verification
  setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(() => LoginScreen());
        TLoaders.successSnackBar(
            title: 'Vérification Réussie',
            message: 'Votre email a été vérifié avec succès!');
      }
    });
  }

  /// Manually check if email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await currentUser?.reload(); // Add reload before checking
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: TImages.successfullyRegisterAnimation,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
