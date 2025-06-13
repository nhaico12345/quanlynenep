import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/utils/validators.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Giả lập đăng nhập
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Chuyển hướng đến màn hình dashboard dựa trên vai trò
        Navigator.pushReplacementNamed(context, '/dashboard');

        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.loginSuccess),
            backgroundColor: AppTheme.successColor,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildLoginForm(),
                  const SizedBox(height: 24),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo hoặc icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.school,
            size: 60,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        // Tiêu đề
        const Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Mô tả
        const Text(
          'Hệ thống quản lý nề nếp học sinh',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: AppConstants.usernameLabel,
          hint: 'Nhập tên đăng nhập',
          controller: _usernameController,
          prefixIcon: Icons.person,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: Validators.validateRequired,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: AppConstants.passwordLabel,
          hint: 'Nhập mật khẩu',
          controller: _passwordController,
          prefixIcon: Icons.lock,
          suffixIcon: _obscurePassword ? Icons.visibility : Icons.visibility_off,
          onSuffixIconPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          validator: Validators.validatePassword,
          onSubmitted: (_) => _login(),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: AppConstants.loginButton,
      onPressed: _login,
      isLoading: _isLoading,
      isFullWidth: true,
      height: 50,
    );
  }
}