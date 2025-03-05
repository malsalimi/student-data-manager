import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'update_student_screen.dart';

class StudentsListScreen extends StatefulWidget {
  @override
  _StudentsListScreenState createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  List students = [];
  bool isLoading = true;

  Future<void> fetchStudents() async {
    try {
      var url = Uri.parse("http://10.0.2.2/flutter_1/get_students.php");
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["status"] == "success" && jsonResponse["data"] is List) {
        setState(() {
          students = jsonResponse["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          students = [];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        students = [];
        isLoading = false;
      });
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      var url = Uri.parse("http://10.0.2.2/flutter_1/delete_student.php");
      var response = await http.post(url, body: {"id": id});
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["status"] == "success") {
        setState(() {
          students.removeWhere((student) => student["id"] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ تم حذف الطالب بنجاح")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ فشل الحذف: ${jsonResponse["message"]}")),
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
    fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("قائمة الطلاب")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : students.isEmpty
              ? Center(child: Text("لا توجد بيانات متاحة"))
              : ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          students[index]["name"],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetailsScreen(
                                student: students[index],
                                onDelete: deleteStudent,
                                onUpdate: fetchStudents,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class StudentDetailsScreen extends StatelessWidget {
  final Map student;
  final Function(String) onDelete;
  final Function() onUpdate;

  StudentDetailsScreen({
    required this.student,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفاصيل الطالب")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("الاسم: ${student["name"]}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("البريد الإلكتروني: ${student["email"]}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("الهاتف: ${student["phone"]}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("القسم: ${student["department"]}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("رجوع"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateStudentScreen(student: student),
                      ),
                    ).then((_) => onUpdate());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("تعديل"),
                ),
                ElevatedButton(
                  onPressed: () {
                    onDelete(student["id"]);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("حذف الطالب"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
