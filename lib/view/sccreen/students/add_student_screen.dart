import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  Future<void> addStudent() async {
    // التأكد من أن جميع الحقول ممتلئة قبل الإرسال
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        departmentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى ملء جميع الحقول")),
      );
      return;
    }

    var url = Uri.parse("http://10.0.2.2/flutter_1/add_student.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "department": departmentController.text,
      },
    );

    print("Response Body: ${response.body}");

    try {
      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تمت إضافة الطالب بنجاح")),
        );
        Navigator.pop(context, true); // إرسال إشعار بنجاح الإضافة
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "حدث خطأ أثناء الإضافة")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في الاتصال بالسيرفر")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة طالب")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "الاسم")),
            TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "البريد الإلكتروني")),
            TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "رقم الهاتف")),
            TextField(
                controller: departmentController,
                decoration: InputDecoration(labelText: "القسم")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addStudent,
              child: Text("إضافة"),
            ),
          ],
        ),
      ),
    );
  }
}
