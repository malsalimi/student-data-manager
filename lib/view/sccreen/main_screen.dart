import 'package:flutter/material.dart';
import 'package:project_levevl_3/view/sccreen/login_screen.dart';
import 'package:project_levevl_3/view/sccreen/students/add_student_screen.dart';
import 'package:project_levevl_3/view/sccreen/students/students_list_screen.dart';

class MainScreen extends StatelessWidget {
  final String email; // استقبال البريد الإلكتروني من شاشة تسجيل الدخول

  const MainScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الرئيسية")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/p10.png'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    email, // عرض البريد الإلكتروني بدلاً من "محمد السالمي"
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('إضافة طالب'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStudentScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('عرض الطلاب'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentsListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: [
          buildCard(
              "إضافة طالب", Icons.person_add, context, AddStudentScreen()),
          buildCard("عرض الطلاب", Icons.list, context, StudentsListScreen()),
          buildCard("إعدادات", Icons.settings, context, SettingsScreen()),
          buildCard("مساعدة", Icons.help, context, HelpScreen()),
        ],
      ),
    );
  }

  Widget buildCard(
      String title, IconData icon, BuildContext context, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blue),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// يمكنك إنشاء هذه الصفحات لاحقًا أو استبدالها بالشاشات الفعلية
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("الإعدادات")),
        body: Center(child: Text("صفحة الإعدادات")));
  }
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("المساعدة")),
        body: Center(child: Text("صفحة المساعدة")));
  }
}
