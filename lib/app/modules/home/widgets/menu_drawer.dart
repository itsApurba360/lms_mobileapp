import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/routes/app_pages.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildLogoOnly(context),
              const Divider(thickness: 1, height: 1),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  children: [
                    _buildMenuItem(
                        context, Icons.dashboard_outlined, 'Home', Routes.HOME),
                    _buildMenuItem(context, Icons.person_outline, 'My Profile',
                        Routes.PROFILE),
                    _buildMenuItem(context, Icons.school_outlined, 'My Courses',
                        Routes.COURSES),
                    _buildMenuItem(context, Icons.chat_bubble_outline_outlined,
                        'Chat', Routes.CHAT),
                    _buildMenuItem(context, Icons.assignment_outlined,
                        'Assessments', Routes.TESTSERIES),
                    _buildMenuItem(context, Icons.settings_outlined, 'Settings',
                        Routes.SETTINGS),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoOnly(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/logo.png',
          width: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String label, String route) {
    final isActive = Get.currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? Colors.green.shade50 : Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            if (!isActive) {
              Get.offAllNamed(route);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: [
                Icon(icon,
                    color: isActive ? Colors.green : Colors.grey[700],
                    size: 22),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: isActive ? Colors.green : Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close dialog
                      // Navigate to home
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.HOME,
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close dialog
                      // Navigate to login and clear stack
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.LOGIN,
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red.shade400, size: 22),
              const SizedBox(width: 16),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
