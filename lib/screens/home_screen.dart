import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stree/controllers/auth_controller.dart';
import 'package:stree/constans/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Vendosja manuale e ikonës së kthimit në fund të shiritit të aplikacionit
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: Get.theme.iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Vendosja e përmbajtjes në mes të kolonës
          crossAxisAlignment: CrossAxisAlignment
              .center, // Vendosja e përmbajtjes në mes të rreshtit
          children: [
            Text(
              'Yow are now Home', // Teksti që shfaqet në ekran
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.mainTextColor,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'All you can do here is get out', // Teksti që shfaqet në ekran
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 61,
            ),
            GestureDetector(
              onTap: () async {
                await authController
                    .logout(); // Thirrja e metodes "logout" në objektin "authController" kur përdoruesi klikon në butonin "Logout"
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  'Logout', // Teksti që shfaqet në butonin "Logout"
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
