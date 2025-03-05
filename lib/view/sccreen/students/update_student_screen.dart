import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateStudentScreen extends StatefulWidget {
  final Map student;
  UpdateStudentScreen({required this.student});

  @override
  _UpdateStudentScreenState createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController departmentController;

  Future<void> updateStudent() async {
    var url = Uri.parse("http://10.0.2.2/flutter_1/update_student.php");

    try {
      var response = await http.post(url, body: {
        "id": widget.student["id"].toString(), // ✅ تحويل ID إلى نص
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "department": departmentController.text.trim(),
      });

      // ✅ التحقق من حالة الاستجابة قبل محاولة تحليل JSON
      if (response.statusCode == 200) {
        try {
          var data = jsonDecode(response.body);

          if (data["status"] == "success") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("✅ تم تحديث بيانات الطالب بنجاح")),
            );
            Navigator.pop(context, true); // إرجاع قيمة إلى الصفحة السابقة
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ فشل التحديث: ${data["message"]}")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ خطأ في تحليل البيانات المستلمة!")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ خطأ في الخادم: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ حدث خطأ: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student["name"]);
    emailController = TextEditingController(text: widget.student["email"]);
    phoneController = TextEditingController(text: widget.student["phone"]);
    departmentController =
        TextEditingController(text: widget.student["department"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تحديث بيانات الطالب")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "الاسم")),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "البريد الإلكتروني")),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "رقم الهاتف")),
            TextField(
                controller: departmentController,
                decoration: InputDecoration(labelText: "القسم")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateStudent,
              child: Text("تحديث"),
            ),
          ],
        ),
      ),
    );
  }
}
