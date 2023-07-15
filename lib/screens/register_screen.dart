import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stree/controllers/auth_controller.dart';
import 'package:stree/wigets/custom_text_field_widget.dart';
import 'package:stree/constans/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stree/constans/validator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  var costumSizedBox = const SizedBox(
    width: 10,
  );

  final sizedBoxHeight = 15.0;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        // toolbarHeight: 0,
        iconTheme: Get.theme.iconTheme,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Register to Stree',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Form(
                  key: authController.registerFormKey.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: authController.registerScreenListener(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFiledWidget(
                        controller: authController.fullNameController.value,
                        label: 'Full name',
                        fillColor: Colors.grey,
                        validator: (value) => Validator.validateFullName(value),
                      ),
                      SizedBox(height: sizedBoxHeight),
                      CustomTextFiledWidget(
                        controller: authController.emailController.value,
                        label: 'Email',
                        fillColor: Colors.grey,
                        validator: (value) => Validator.validateEmail(value),
                      ),
                      SizedBox(height: sizedBoxHeight),
                      CustomTextFiledWidget(
                        controller: authController.mobileNumberController.value,
                        label: 'Mobile Number',
                        fillColor: Colors.grey,
                        validator: (value) =>
                            Validator.validateMobileNumber(value),
                      ),
                      SizedBox(height: sizedBoxHeight),
                      CustomTextFiledWidget(
                        controller: authController.fullPasswordController.value,
                        label: 'Password',
                        fillColor: Colors.grey,
                        obscureText: true,
                        validator: (value) => Validator.validatePassword(value),
                      ),

                      SizedBox(height: sizedBoxHeight),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4.0,
                              color: authController.barColor1.value,
                            ),
                          ),
                          costumSizedBox,
                          Expanded(
                            child: Container(
                              height: 4.0,
                              color: authController.barColor2.value,
                            ),
                          ),
                          costumSizedBox,
                          Expanded(
                            child: Container(
                              height: 4.0,
                              color: authController.barColor3.value,
                            ),
                          ),
                          costumSizedBox,
                          Expanded(
                            child: Container(
                              height: 4.0,
                              color: authController.barColor4.value,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: sizedBoxHeight),
                      CustomTextFiledWidget(
                        controller:
                            authController.confirmPasswordController.value,
                        label: 'Confirm Password',
                        obscureText: true,
                        fillColor: Colors.grey,
                        validator: (value) {
                          if (authController
                                  .confirmPasswordController.value.text !=
                              authController
                                  .fullPasswordController.value.text) {
                            return 'Password is not the same';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: sizedBoxHeight),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: sizedBoxHeight),
                    GestureDetector(
                      onTap: () async {
                        await authController.signUp();
                        // Get.to(() => const HomeScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: authController.enableLoginButton.value == true
                              ? AppColors.mainColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(
                          text: "By registering you agree to  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.mainTextColor),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.mainColor,
                              ),
                            ),
                            TextSpan(
                              text: "and  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColors.mainTextColor),
                              children: [
                                TextSpan(
                                  text: 'Privacy Policy ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "of Stree  ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColors.mainTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
