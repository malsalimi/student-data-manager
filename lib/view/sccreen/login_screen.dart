import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_levevl_3/controller/login_controller.dart';
import 'package:project_levevl_3/view/sccreen/signUp_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.school,
                      size: 60,
                      color: Colors.blue.shade800,
                    ),
                    const SizedBox(height: 20),
                    _buildTitle(),
                    const SizedBox(height: 20),
                    _buildTextField(
                        controller.emailController, "Email", Icons.email),
                    const SizedBox(height: 20),
                    _buildTextField(
                        controller.passwordController, "Password", Icons.lock,
                        ispassword: true),
                    const SizedBox(height: 20),
                    _buildLoginButton(controller),
                    const SizedBox(height: 20),
                    _buildSignUpText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Welcome",
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool ispassword = false}) {
    return TextField(
      controller: controller,
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade800),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginController controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: controller.login,
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildSignUpText() {
    return TextButton(
      onPressed: () => Get.to(() => const SignUpScreen()),
      child: Text(
        'Don\'t have an account? Sign Up',
        style: TextStyle(color: Colors.blue.shade800, fontSize: 16),
      ),
    );
  }
}
