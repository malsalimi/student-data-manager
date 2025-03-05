import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_levevl_3/controller/signUp_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
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
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 60,
                        color: Colors.blue.shade800,
                      ),
                      const SizedBox(height: 20),
                      _buildTitle(),
                      const SizedBox(height: 20),
                      _buildTextField(signUpController.nameController, "Name",
                          Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(signUpController.emailController, "Email",
                          Icons.email),
                      const SizedBox(height: 15),
                      _buildTextField(signUpController.passwordController,
                          "Password", Icons.lock,
                          ispassword: true),
                      const SizedBox(height: 15),
                      _buildTextField(
                          signUpController.confirmPasswordController,
                          "Confirm Password",
                          Icons.lock,
                          ispassword: true),
                      const SizedBox(height: 20),
                      _buildLoginButton(
                        onPressed: () => signUpController.signUp(),
                      ),
                      const SizedBox(height: 20),
                      _buildLoginLink(),
                    ],
                  ),
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
      "Create Account",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
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

  Widget _buildLoginButton({required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: const Text("Sign Up", style: TextStyle(fontSize: 20)),
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () => Get.back(),
      child: Text(
        'Already have an account? Login',
        style: TextStyle(color: Colors.blue.shade800, fontSize: 16),
      ),
    );
  }
}
