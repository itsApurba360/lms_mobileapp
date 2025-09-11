import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/modules/login/controllers/login_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import 'package:lms_app/app/utils/widgets/custom_loading_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController());
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png', // 👈 Update your logo path
                height: 50,
              ),

              const SizedBox(height: 24),

              // "Login to continue"
              Text(
                "Login to continue",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 24),

              // Email or Mobile Input
              TextFormField(
                controller: controller.emailController,
                cursorColor: Colors.grey.shade300,
                decoration: InputDecoration(
                  labelText: 'Email or Mobile',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.grey.shade700),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Password Input with Eye Toggle
              TextFormField(
                controller: controller.passwordController,
                obscureText: _obscurePassword,
                cursorColor: Colors.grey.shade300,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.grey.shade700),
                ),
              ),

              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: CustomLoadingButton(
                  onPressed: () async {
                    await controller.login();
                  },
                  text: 'Login',
                ),
              ),

              // "Login with Mobile Number" Text Button
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () => Get.to(() => OtpLoginView()),
              //     child: Text(
              //       "Login with Mobile Number",
              //       style: TextStyle(
              //         color: Theme.of(Get.context!).colorScheme.primary,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.offNamed(Routes.REGISTER),
                    child: Text(
                      "Create new",
                      style: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
