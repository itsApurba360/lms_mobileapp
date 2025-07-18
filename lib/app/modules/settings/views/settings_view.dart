import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsView'),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor, // 👈 Set light grey bg
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<SettingsController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _passwordField(
                    label: 'Current Password',
                    controller: controller.currentPasswordController,
                    isObscured: controller.currentObscured,
                    toggle: () => controller.toggleObscure('current'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password action
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _passwordField(
                    label: 'New Password',
                    controller: controller.newPasswordController,
                    isObscured: controller.newObscured,
                    toggle: () => controller.toggleObscure('new'),
                  ),
                  const SizedBox(height: 20),
                  _passwordField(
                    label: 'Confirm New Password',
                    controller: controller.confirmPasswordController,
                    isObscured: controller.confirmObscured,
                    toggle: () => controller.toggleObscure('confirm'),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle profile update
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool isObscured,
    required VoidCallback toggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isObscured,
          obscuringCharacter: '•',
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }
}
