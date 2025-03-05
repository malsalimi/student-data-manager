// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_levevl_3/view/sccreen/login_screen.dart';
import '../view/sccreen/signUp_screen.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // inserrecord() {}
  Future<void> signUp() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar("خطا", "يرجى ملء جميع الحقول",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("خطا", "كلمة المرور وتأكيد كلمة المرور غير متطابقين",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return;
    }

    // تحقق من صحة البريد الإلكتروني
    String email = emailController.text.trim();
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      Get.snackbar("خطا", "البريد الإلكتروني غير صالح",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return;
    }

    // إرسال البيانات إلى السيرفر
    var response = await http.post(
      Uri.parse("http://10.0.2.2/flutter_1/signup.php"), // تم التعديل هنا
      body: {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == "success") {
        Get.snackbar(
          "تم",
          "تم التسجيل بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );

        // تنظيف الحقول بعد النجاح
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Get.to(() => LoginScreen());
      } else {
        Get.snackbar(
          "خطا",
          data["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        "خطا",
        "حدث خطأ في الاتصال بالسيرفر",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
