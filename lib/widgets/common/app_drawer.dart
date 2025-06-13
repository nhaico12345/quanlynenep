import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  final String userRole;
  final String userName;
  final String? userAvatar;

  const AppDrawer({
    Key? key,
    required this.currentRoute,
    required this.userRole,
    required this.userName,
    this.userAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildMenuItems(context),
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
      ),
      accountName: Text(
        userName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      accountEmail: Text(
        _getRoleName(),
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: userAvatar != null ? NetworkImage(userAvatar!) : null,
        child: userAvatar == null
            ? Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              )
            : null,
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final List<Widget> menuItems = [
      _buildMenuItem(
        context,
        title: AppConstants.dashboardTitle,
        icon: Icons.dashboard,
        route: '/dashboard',
      ),
    ];

    // Menu cho Ban nề nếp và Giáo viên
    if (userRole == AppConstants.roleDisciplineTeam ||
        userRole == AppConstants.roleTeacher) {
      menuItems.add(
        _buildMenuItem(
          context,
          title: AppConstants.disciplineTitle,
          icon: Icons.assignment,
          route: '/discipline',
        ),
      );

      menuItems.add(
        _buildMenuItem(
          context,
          title: AppConstants.violationTitle,
          icon: Icons.warning,
          route: '/violation',
        ),
      );
    }

    // Menu cho tất cả người dùng
    menuItems.add(
      _buildMenuItem(
        context,
        title: AppConstants.reportsTitle,
        icon: Icons.bar_chart,
        route: '/reports',
      ),
    );

    // Menu chỉ dành cho Admin (Ban giám hiệu)
    if (userRole == AppConstants.roleAdmin) {
      menuItems.add(
        const Divider(),
      );

      menuItems.add(
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Text(
            'Quản lý hệ thống',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ),
      );

      menuItems.add(
        _buildMenuItem(
          context,
          title: AppConstants.classManagementTitle,
          icon: Icons.school,
          route: '/management/class',
        ),
      );

      menuItems.add(
        _buildMenuItem(
          context,
          title: AppConstants.studentManagementTitle,
          icon: Icons.people,
          route: '/management/student',
        ),
      );

      menuItems.add(
        _buildMenuItem(
          context,
          title: AppConstants.criteriaManagementTitle,
          icon: Icons.rule,
          route: '/management/criteria',
        ),
      );

      menuItems.add(
        _buildMenuItem(
          context,
          title: AppConstants.accountManagementTitle,
          icon: Icons.manage_accounts,
          route: '/management/account',
        ),
      );
    }

    return menuItems;
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
  }) {
    final bool isSelected = currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppTheme.primaryColor.withOpacity(0.1),
      onTap: () {
        if (!isSelected) {
          Navigator.pop(context); // Đóng drawer
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppTheme.errorColor,
            ),
            title: const Text(
              AppConstants.logoutButton,
              style: TextStyle(
                color: AppTheme.errorColor,
              ),
            ),
            onTap: () {
              // Xử lý đăng xuất
              Navigator.pop(context); // Đóng drawer
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  String _getRoleName() {
    switch (userRole) {
      case AppConstants.roleAdmin:
        return 'Ban Giám Hiệu';
      case AppConstants.roleTeacher:
        return 'Giáo Viên';
      case AppConstants.roleDisciplineTeam:
        return 'Ban Nề Nếp';
      default:
        return 'Người Dùng';
    }
  }
}