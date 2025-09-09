import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:lms_app/app/utils/widgets/custom_loading_button.dart';

class MyprofileView extends GetView<ProfileController> {
  const MyprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture with edit icon
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Name
              _buildTextField(
                  label: 'Name',
                  initialValue: controller.userDetails.user?.fullName),
              const SizedBox(height: 16),

              // Phone Number
              _buildTextField(
                  label: 'Phone Number',
                  initialValue: controller.userDetails.user?.mobileNo),
              const SizedBox(height: 12),

              // Phone Update Button
              const SizedBox(height: 16),

              // Email
              _buildTextField(
                  label: 'Email',
                  initialValue: controller.userDetails.user?.email),

              const SizedBox(height: 32),

              // Update Profile Button
              SizedBox(
                width: double.infinity,
                child: CustomLoadingButton(
                    text: 'Update Profile', onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? initialValue,
    String? hintText,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: _inputDecoration(label).copyWith(hintText: hintText),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    );
  }
}
