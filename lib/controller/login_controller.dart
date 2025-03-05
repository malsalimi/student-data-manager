// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_levevl_3/view/sccreen/main_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2/flutter_1/login.php"),
      body: {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == "success") {
        Get.snackbar("تم", "تم تسجيل الدخول بنجاح",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);

        // تمرير البريد الإلكتروني إلى MainScreen
        Get.offAll(() => MainScreen(email: emailController.text.trim()));
      } else {
        Get.snackbar(
          " خطأ",
          data["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar("خطأ حدث", "حدث خطأ ما",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }
}