import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stree/screens/login_screen.dart';
import 'package:stree/screens/home_screen.dart';

import 'controllers/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final AuthController authController =
      Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        home: authController.isLoggedIn.value == true
            ? HomeScreen()
            : LoginScreen(),
      ),
    );
  }
}
