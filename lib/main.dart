import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_levevl_3/view/sccreen/login_screen.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // تأكد من تهيئة الـ Plugins

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sutudent management app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
