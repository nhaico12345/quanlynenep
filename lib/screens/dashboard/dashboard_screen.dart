import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Giả lập dữ liệu người dùng
  final String _userRole = AppConstants.roleAdmin; // Có thể thay đổi để test các vai trò khác
  final String _userName = 'Nguyễn Văn A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.dashboardTitle),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        currentRoute: '/dashboard',
        userRole: _userRole,
        userName: _userName,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(),
              const SizedBox(height: 24),
              _buildStatusSection(),
              const SizedBox(height: 24),
              _buildRecentActivitiesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xin chào, $_userName!',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Chào mừng bạn đến với ${AppConstants.appName}',
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tổng quan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStatusCard(
              title: 'Tổng số lớp',
              value: '12',
              icon: Icons.school,
              color: AppTheme.primaryColor,
              onTap: () {
                if (_userRole == AppConstants.roleAdmin) {
                  Navigator.pushNamed(context, '/management/class');
                }
              },
            ),
            _buildStatusCard(
              title: 'Tổng số học sinh',
              value: '450',
              icon: Icons.people,
              color: AppTheme.secondaryColor,
              onTap: () {
                if (_userRole == AppConstants.roleAdmin) {
                  Navigator.pushNamed(context, '/management/student');
                }
              },
            ),
            _buildStatusCard(
              title: 'Vi phạm tuần này',
              value: '15',
              icon: Icons.warning,
              color: AppTheme.errorColor,
              onTap: () {
                Navigator.pushNamed(context, '/violation');
              },
            ),
            _buildStatusCard(
              title: 'Điểm nề nếp TB',
              value: '85',
              icon: Icons.star,
              color: AppTheme.accentColor,
              onTap: () {
                Navigator.pushNamed(context, '/reports');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      onTap: onTap,
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hoạt động gần đây',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                // Xem tất cả hoạt động
              },
              child: const Text('Xem tất cả'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildActivityItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildActivityItem(int index) {
    // Giả lập dữ liệu hoạt động
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Chấm điểm nề nếp lớp 10A1',
        'time': '10:30 - 15/06/2023',
        'user': 'Nguyễn Văn B',
        'icon': Icons.assignment,
        'color': AppTheme.primaryColor,
      },
      {
        'title': 'Báo cáo vi phạm học sinh Trần C',
        'time': '09:15 - 15/06/2023',
        'user': 'Lê Thị D',
        'icon': Icons.warning,
        'color': AppTheme.errorColor,
      },
      {
        'title': 'Xác nhận điểm nề nếp tuần 20',
        'time': '16:45 - 14/06/2023',
        'user': 'Phạm Văn E',
        'icon': Icons.check_circle,
        'color': AppTheme.successColor,
      },
      {
        'title': 'Thêm tiêu chí chấm điểm mới',
        'time': '14:20 - 14/06/2023',
        'user': 'Nguyễn Văn A',
        'icon': Icons.add_circle,
        'color': AppTheme.secondaryColor,
      },
      {
        'title': 'Xuất báo cáo tháng 5/2023',
        'time': '11:05 - 13/06/2023',
        'user': 'Nguyễn Văn A',
        'icon': Icons.bar_chart,
        'color': AppTheme.accentColor,
      },
    ];

    final activity = activities[index];

    return InfoCard(
      title: activity['title'],
      subtitle: '${activity['time']} bởi ${activity['user']}',
      icon: activity['icon'],
      iconColor: activity['color'],
      onTap: () {
        // Xem chi tiết hoạt động
      },
    );
  }
}