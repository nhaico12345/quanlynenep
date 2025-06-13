import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/screens/auth/login_screen.dart';
import 'package:quanlynenep/screens/dashboard/dashboard_screen.dart';
import 'package:quanlynenep/screens/discipline/discipline_screen.dart';
import 'package:quanlynenep/screens/management/class_management_screen.dart';
import 'package:quanlynenep/screens/management/criteria_management_screen.dart';
import 'package:quanlynenep/screens/management/student_management_screen.dart';
import 'package:quanlynenep/screens/management/user_management_screen.dart';
import 'package:quanlynenep/screens/reports/reports_screen.dart';
import 'package:quanlynenep/screens/violation/violation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/discipline': (context) => const DisciplineScreen(),
        '/violation': (context) => const ViolationScreen(),
        '/reports': (context) => const ReportsScreen(),
        '/management/class': (context) => const ClassManagementScreen(),
        '/management/student': (context) => const StudentManagementScreen(),
        '/management/criteria': (context) => const CriteriaManagementScreen(),
        '/management/user': (context) => const UserManagementScreen(),
      },
    );
  }
}
