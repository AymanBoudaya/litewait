import 'package:caferesto/features/authentication/screens/login/login.dart';
import 'package:caferesto/features/shop/screens/home/home.dart';
import 'package:caferesto/features/shop/screens/store/store.dart';
import 'package:caferesto/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_binding.dart';
import 'utils/constants/colors.dart';

class App extends StatelessWidget {
  final routes = {
    '/home': (context) => HomeScreen(),
    '/store': (context) => const StoreScreen(),
    '/authentification': (context) => const LoginScreen(),
  };

  App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBinding(),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: const Scaffold(
          backgroundColor: TColors.primary,
          body: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        ),
    );
  }
}
/*const Scaffold(
          backgroundColor: TColors.primary,
          body: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        )*/
/*
FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool conn = snapshot.data?.getBool('connecte') ?? false;
            if (conn) return HomeScreen();
          }
          return const LoginScreen();
        },
      ),*/
