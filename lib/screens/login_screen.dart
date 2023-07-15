import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stree/controllers/auth_controller.dart';
import 'package:stree/screens/register_screen.dart';
import 'package:stree/constans/colors.dart';
// import 'package:stree/src/features/dashboard/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Kontrolleri i autentifikimit
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imazhi
                  Image.asset(
                    'assets/images/Frame.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Fusha e plotësimit të email-it
                  TextField(
                    controller: authController.emailController.value,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Fusha e plotësimit të fjalëkalimit
                  TextField(
                    controller: authController.fullPasswordController.value,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 18),

                  // Teksti "Forgot Password?"
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                      color: AppColors.mainColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 30.0),

                  // Butoni "Login"
                  GestureDetector(
                    onTap: authController.enableLoginButton.value == true
                        ? () async {
                            await authController.login();
                            // Get.to(() => const HomeScreen());
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                          color: authController.enableLoginButton.value == true
                              ? AppColors.mainColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(7)),
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Teksti "Don't have an account? Register Now"
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'Register Now',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
