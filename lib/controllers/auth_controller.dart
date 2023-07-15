import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stree/models/user_model.dart';
import 'package:stree/screens/login_screen.dart';
import 'package:stree/screens/home_screen.dart';

class AuthController extends GetxController {
  final fullNameController = TextEditingController()
      .obs; // Kontrolleri për fushën e emrit të plotë (e mbuluar nga GetX)
  final emailController = TextEditingController()
      .obs; // Kontrolleri për fushën e email-it (e mbuluar nga GetX)
  final mobileNumberController = TextEditingController()
      .obs; // Kontrolleri për fushën e numrit të telefonit (e mbuluar nga GetX)
  final fullPasswordController = TextEditingController()
      .obs; // Kontrolleri për fushën e fjalëkalimit (e mbuluar nga GetX)
  final confirmPasswordController = TextEditingController()
      .obs; // Kontrolleri për fushën e konfirmimit të fjalëkalimit (e mbuluar nga GetX)
  var usersList =
      <UserModel>[].obs; // Lista e modeleve të përdoruesve (e mbuluar nga GetX)
  var isLoggedIn = false
      .obs; // Flamuri që tregon nëse përdoruesi është i kyçur (e mbuluar nga GetX)

  var enableLoginButton = false
      .obs; // Flamuri që tregon nëse butoni i kyçjes është i aktivizuar (e mbuluar nga GetX)
  var enableRegisterButton = false
      .obs; // Flamuri që tregon nëse butoni i regjistrimit është i aktivizuar (e mbuluar nga GetX)

  var barColor1 = Colors.grey.obs; // Ngjyra e shiritit 1 (e mbuluar nga GetX)
  var barColor2 = Colors.grey.obs; // Ngjyra e shiritit 2 (e mbuluar nga GetX)
  var barColor3 = Colors.grey.obs; // Ngjyra e shiritit 3 (e mbuluar nga GetX)
  var barColor4 = Colors.grey.obs; // Ngjyra e shiritit 4 (e mbuluar nga GetX)

  final registerFormKey = GlobalKey<FormState>()
      .obs; // Kyç unik për formën e regjistrimit (e mbuluar nga GetX)

  changeEnableButton() {
    if (emailController.value.text.isEmpty ||
        fullPasswordController.value.text.isEmpty) {
      enableLoginButton.value =
          false; // Butoni i kyçjes nuk është i aktivizuar nëse fusha e email-it ose fjalëkalimi janë të zbrazëta
    } else {
      enableLoginButton.value =
          true; // Butoni i kyçjes është i aktivizuar nëse të dy fushat janë të plotësuara
    }
  }

  loginScreenListener() {
    emailController.value.addListener(() {
      changeEnableButton(); // Kontrollon nëse butoni i kyçjes duhet të aktivizohet
    });

    fullPasswordController.value.addListener(() {
      changeEnableButton(); // Kontrollon nëse butoni i kyçjes duhet të aktivizohet
      updateBarColors(); // Përditëson ngjyrat e shiritave sipas kompleksitetit të fjalëkalimit
    });
  }

  registerScreenListener() {
    enableRegisterButton.value =
        registerFormKey.value.currentState?.validate() ??
            false; // Kontrollon nëse butoni i regjistrimit duhet të aktivizohet
  }

  void updateBarColors() {
    var complexity =
        _calculatePasswordComplexity(); // Llogarit kompleksitetin e fjalëkalimit

    if (complexity.value == 1) {
      barColor1.value = Colors.red; // Ngjyra e shiritit 1 është e kuqe
      barColor2.value = Colors.grey;
      barColor3.value = Colors.grey;
      barColor4.value = Colors.grey;
    } else {
      barColor1.value = Colors.grey;
    }

    if (complexity.value == 2) {
      barColor1.value = Colors.orange; // Ngjyra e shiritit 1 është portokalli
      barColor2.value = Colors.orange; // Ngjyra e shiritit 2 është portokalli
      barColor3.value = Colors.grey;
      barColor4.value = Colors.grey;
    } else {
      barColor2.value = Colors.grey;
    }

    if (complexity.value == 3) {
      barColor1.value = Colors.yellow; // Ngjyra e shiritit 1 është e verdhë
      barColor2.value = Colors.yellow; // Ngjyra e shiritit 2 është e verdhë
      barColor3.value = Colors.yellow; // Ngjyra e shiritit 3 është e verdhë
      barColor4.value = Colors.grey;
    } else {
      barColor3.value = Colors.grey;
    }

    if (complexity.value == 4) {
      barColor1.value = Colors.green; // Ngjyra e shiritit 1 është jeshile
      barColor2.value = Colors.green; // Ngjyra e shiritit 2 është jeshile
      barColor3.value = Colors.green; // Ngjyra e shiritit 3 është jeshile
      barColor4.value = Colors.green; // Ngjyra e shiritit 4 është jeshile
    } else {
      barColor4.value = Colors.grey;
    }
  }

  RxInt _calculatePasswordComplexity() {
    var complexity = 0.obs; // Kompleksiteti i fjalëkalimit (e mbuluar nga GetX)

    if (fullPasswordController.value.text.length >= 9) {
      complexity++;
    }

    if (fullPasswordController.value.text.contains(RegExp(r'[A-Z]'))) {
      complexity++;
    }

    if (fullPasswordController.value.text.contains(RegExp(r'[a-z]'))) {
      complexity++;
    }

    if (fullPasswordController.value.text.contains(RegExp(r'[0-9]'))) {
      complexity++;
    }

    return complexity; // Kthen kompleksitetin e fjalëkalimit
  }

  login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await fetchUsersList(); // Merr listën e përdoruesve

    var selectedUser = usersList.firstWhereOrNull((user) =>
        user.email == emailController.value.text &&
        user.password ==
            fullPasswordController.value
                .text); // Gjen përdoruesin e selektuar në bazë të email-it dhe fjalëkalimit

    if (selectedUser == null || selectedUser.email.isEmpty) {
      Get.snackbar(
        'Opps!',
        'Përdoruesi nuk u gjet!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      ); // Tregon një mesazh të gabimit nëse përdoruesi nuk gjendet
    } else {
      prefs.setBool('isLoggedIn',
          true); // Cakton vlerën "true" për çelësin "isLoggedIn" në SharedPreferences
      Get.offAll(() => HomeScreen()); // Kalon në ekranin HomeScreen
    }
  }

  signUp() async {
    if (!registerFormKey.value.currentState!.validate()) {
      Get.snackbar(
        'Opps!',
        'Ju lutem plotësoni formën për të vazhduar!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      ); // Tregon një mesazh të gabimit nëse forma nuk është valide
      return;
    }

    registerFormKey.value.currentState!.save(); // Ruajtja e vlerave të formës

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      usersList.add(
        UserModel(
          fullName: fullNameController.value.text,
          id: '${fullNameController.value.text}${fullPasswordController.value.text}',
          email: emailController.value.text,
          password: fullPasswordController.value.text,
          phoneNumber: mobileNumberController.value.text,
        ),
      ); // Shtimi i një modeli të përdoruesit në listë

      prefs.setStringList(
        'usersList',
        usersList
            .map((element) => jsonEncode(element.toJson()).toString())
            .toList(),
      ); // Ruajtja e listës së përdoruesve në SharedPreferences

      prefs.setBool('isLoggedIn',
          true); // Cakton vlerën "true" për çelësin "isLoggedIn" në SharedPreferences
      Get.offAll(() => HomeScreen()); // Kalon në ekranin HomeScreen
    } catch (e) {
      print(
          'Gabim gjatë regjistrimit: $e'); // Tregon gabimin nëse ka ndodhur ndonjë gabim gjatë regjistrimit
    }
  }

  fetchUsersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('usersList') ??
        []; // Merr listën e përdoruesve nga SharedPreferences

    usersList.value = list
        .map<UserModel>((e) => UserModel.fromJson(jsonDecode(e)))
        .toList(); // Krijon modele të përdoruesve nga stringjet e ruajtura

    print(
        'Lista e përdoruesve: ${usersList.first.email}'); // Tregon listën e përdoruesve në terminal
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(
        'isLoggedIn'); // Fshin çelësin "isLoggedIn" nga SharedPreferences
    Get.offAll(() => LoginScreen()); // Kalon në ekranin LoginScreen
  }

  isAuthenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ??
        false; // Merr vlerën "isLoggedIn" nga SharedPreferences ose vendos vlerën parazgjedhje false nëse nuk gjendet
  }

  @override
  void onInit() async {
    await isAuthenticated();
    loginScreenListener(); // Vendos dëgjuesin për ekranin e kyçjes

    super.onInit();
  }
}
