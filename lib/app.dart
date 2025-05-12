import 'package:caferesto/features/authentication/screens/login/login.dart';
import 'package:caferesto/features/shop/screens/store/store.dart';
import 'package:caferesto/pages/home.page.dart';
import 'package:caferesto/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final routes = {
    '/home': (context) => HomePage(),
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
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool conn = snapshot.data?.getBool('connecte') ?? false;
            if (conn) return HomePage();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
