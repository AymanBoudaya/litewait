import 'package:caferesto/features/authentication/screens/login/login.dart';
import 'package:caferesto/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:caferesto/utils/exceptions/firebase_exceptions.dart';
import 'package:caferesto/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    //super.onReady();
    print('[DEBUG] onReady called');
    // Remove the native splash screen
    //FlutterNativeSplash.remove();

    // Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to show relevant screen
  screenRedirect() async {
    // Local Storage
    deviceStorage.writeIfNull('IsFirstTime', true);

    // Check if it's the first time launching the app
    deviceStorage.read('IsFirstTime') != true ?
      // Redirect to OnBoarding Screen
      Get.offAll(() =>
          const LoginScreen()) : // Pour plus de rapidité cas le plus fréquent
      // Redirect to On barding Screen
      Get.offAll(() => const LoginScreen());
    }
  

  /* --- Email & Password sign-in ---*/
  // [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
