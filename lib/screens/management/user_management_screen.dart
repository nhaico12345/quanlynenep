import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';
import 'package:quanlynenep/widgets/common/custom_text_field.dart';
import 'package:quanlynenep/utils/validators.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final String _userRole = AppConstants.roleAdmin; // Giả lập vai trò người dùng
  final String _userName = 'Admin';
  String _searchQuery = '';
  String _selectedRole = 'Tất cả';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.userManagementTitle),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        currentRoute: '/management/user',
        userRole: _userRole,
        userName: _userName,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditUserDialog(context);
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _searchController,
                  hint: 'Tìm kiếm người dùng...',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              CustomButton(
                text: 'Lọc',
                icon: Icons.filter_list,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: _selectedRole,
              isExpanded: true,
              underline: const SizedBox(),
              items: [
                'Tất cả',
                AppConstants.roleAdmin,
                AppConstants.roleTeacher,
                AppConstants.roleMonitor,
              ].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    // Giả lập dữ liệu người dùng
    final List<Map<String, dynamic>> users = [
      {
        'id': '1',
        'username': 'admin',
        'fullName': 'Quản trị viên',
        'email': 'admin@school.edu.vn',
        'phone': '0901234567',
        'role': AppConstants.roleAdmin,
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '2',
        'username': 'teacher1',
        'fullName': 'Nguyễn Văn A',
        'email': 'teacher1@school.edu.vn',
        'phone': '0912345678',
        'role': AppConstants.roleTeacher,
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '3',
        'username': 'teacher2',
        'fullName': 'Trần Thị B',
        'email': 'teacher2@school.edu.vn',
        'phone': '0923456789',
        'role': AppConstants.roleTeacher,
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '4',
        'username': 'monitor1',
        'fullName': 'Lê Văn C',
        'email': 'monitor1@school.edu.vn',
        'phone': '0934567890',
        'role': AppConstants.roleMonitor,
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '5',
        'username': 'monitor2',
        'fullName': 'Phạm Thị D',
        'email': 'monitor2@school.edu.vn',
        'phone': '0945678901',
        'role': AppConstants.roleMonitor,
        'avatar': null,
        'isActive': false,
      },
    ];

    // Lọc người dùng theo từ khóa tìm kiếm và vai trò
    final filteredUsers = users.where((user) {
      final matchesSearch = user['fullName']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          user['username']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          user['email']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesRole =
          _selectedRole == 'Tất cả' || user['role'] == _selectedRole;

      return matchesSearch && matchesRole;
    }).toList();

    if (filteredUsers.isEmpty) {
      return const Center(
        child: Text(
          'Không tìm thấy người dùng nào',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return _buildUserItem(user);
      },
    );
  }

  Widget _buildUserItem(Map<String, dynamic> user) {
    final Color roleColor = _getRoleColor(user['role']);

    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: roleColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    user['fullName'].substring(0, 1),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: roleColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['fullName'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@${user['username']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: roleColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  user['role'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: roleColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: user['isActive'],
                onChanged: (value) {
                  // Cập nhật trạng thái hoạt động của người dùng
                },
                activeColor: AppTheme.primaryColor,
              ),
            ],
          ),
          const Divider(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['email'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Số điện thoại',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['phone'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Đặt lại mật khẩu',
                icon: Icons.lock_reset,
                type: ButtonType.text,
                onPressed: () {
                  _showResetPasswordDialog(context, user);
                },
              ),
              CustomButton(
                text: 'Sửa',
                icon: Icons.edit,
                type: ButtonType.text,
                onPressed: () {
                  _showAddEditUserDialog(context, user: user);
                },
              ),
              CustomButton(
                text: 'Xóa',
                icon: Icons.delete,
                type: ButtonType.text,
                textColor: AppTheme.errorColor,
                iconColor: AppTheme.errorColor,
                onPressed: () {
                  _showDeleteConfirmationDialog(context, user);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case AppConstants.roleAdmin:
        return Colors.red;
      case AppConstants.roleTeacher:
        return Colors.blue;
      case AppConstants.roleMonitor:
        return Colors.green;
      default:
        return AppTheme.primaryColor;
    }
  }

  void _showAddEditUserDialog(BuildContext context, {Map<String, dynamic>? user}) {
    final bool isEditing = user != null;
    final TextEditingController usernameController =
        TextEditingController(text: isEditing ? user['username'] : '');
    final TextEditingController fullNameController =
        TextEditingController(text: isEditing ? user['fullName'] : '');
    final TextEditingController emailController =
        TextEditingController(text: isEditing ? user['email'] : '');
    final TextEditingController phoneController =
        TextEditingController(text: isEditing ? user['phone'] : '');
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    String selectedRole = isEditing ? user['role'] : AppConstants.roleTeacher;
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Sửa thông tin người dùng' : 'Thêm người dùng mới'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: usernameController,
                  labelText: 'Tên đăng nhập',
                  hintText: 'Nhập tên đăng nhập',
                  enabled: !isEditing, // Không cho phép sửa tên đăng nhập khi đang sửa
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên đăng nhập';
                    }
                    if (value.length < 4) {
                      return 'Tên đăng nhập phải có ít nhất 4 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: fullNameController,
                  labelText: 'Họ và tên',
                  hintText: 'Nhập họ và tên',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ và tên';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Nhập địa chỉ email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ email';
                    }
                    if (!Validators.isValidEmail(value)) {
                      return 'Địa chỉ email không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: phoneController,
                  labelText: 'Số điện thoại',
                  hintText: 'Nhập số điện thoại',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (!Validators.isValidPhone(value)) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
 label: 'Vai trò',
                  value: selectedRole,
                  items: [
                    AppConstants.roleAdmin,
                    AppConstants.roleTeacher,
                    AppConstants.roleMonitor,
                  ],
                  onChanged: (value) {
                    selectedRole = value!;
                  },
                ),
 if (!isEditing) ...[ // Chỉ hiển thị trường mật khẩu khi thêm mới
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập mật khẩu',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      if (value.length < 6) {
                        return 'Mật khẩu phải có ít nhất 6 ký tự';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: confirmPasswordController,
                    labelText: 'Xác nhận mật khẩu',
                    hintText: 'Nhập lại mật khẩu',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng xác nhận mật khẩu';
                      }
                      if (value != passwordController.text) {
                        return 'Mật khẩu xác nhận không khớp';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ảnh đại diện (tùy chọn)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.dividerColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 32,
                              color: AppTheme.primaryColor,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Thêm ảnh đại diện',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          CustomButton(
            text: AppConstants.cancelButton,
            type: ButtonType.outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            text: isEditing ? 'Cập nhật' : 'Thêm mới',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                // Lưu thông tin người dùng
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isEditing
                        ? 'Đã cập nhật thông tin người dùng'
                        : 'Đã thêm người dùng mới'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showResetPasswordDialog(BuildContext context, Map<String, dynamic> user) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Đặt lại mật khẩu cho ${user['fullName']}'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: newPasswordController,
                labelText: 'Mật khẩu mới',
                hintText: 'Nhập mật khẩu mới',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu mới';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: confirmPasswordController,
                labelText: 'Xác nhận mật khẩu',
                hintText: 'Nhập lại mật khẩu mới',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng xác nhận mật khẩu';
                  }
                  if (value != newPasswordController.text) {
                    return 'Mật khẩu xác nhận không khớp';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          CustomButton(
            text: AppConstants.cancelButton,
            type: ButtonType.outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            text: 'Đặt lại mật khẩu',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                // Đặt lại mật khẩu cho người dùng
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã đặt lại mật khẩu cho ${user['fullName']}'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text(
            'Bạn có chắc chắn muốn xóa người dùng ${user['fullName']} không? Hành động này không thể hoàn tác.'),
        actions: [
          CustomButton(
            text: AppConstants.cancelButton,
            type: ButtonType.outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            text: 'Xóa',
            backgroundColor: AppTheme.errorColor,
            onPressed: () {
              Navigator.pop(context);
              // Xóa người dùng
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa người dùng'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lọc người dùng'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('Trạng thái',
                ['Tất cả', 'Đang hoạt động', 'Không hoạt động']),
          ],
        ),
        actions: [
          CustomButton(
            text: 'Đặt lại',
            type: ButtonType.outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            text: 'Áp dụng',
            onPressed: () {
              Navigator.pop(context);
              // Áp dụng bộ lọc
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOption(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: options.first,
            isExpanded: true,
            underline: const SizedBox(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}