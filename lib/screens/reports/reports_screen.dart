import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _userRole = AppConstants.roleHeadmaster; // Giả lập vai trò người dùng
  final String _userName = 'Nguyễn Văn A';
  String _selectedClass = 'Tất cả lớp';
  String _selectedPeriod = 'Tuần này';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.reportsTitle),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tổng quan'),
            Tab(text: 'Điểm nề nếp'),
            Tab(text: 'Vi phạm'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              _showPrintDialog();
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        currentRoute: '/reports',
        userRole: _userRole,
        userName: _userName,
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildDisciplineTab(),
                _buildViolationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
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
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
              label: 'Lớp',
              value: _selectedClass,
              items: [
                'Tất cả lớp',
                '10A1',
                '10A2',
                '11A1',
                '11A2',
                '12A1',
                '12A2',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedClass = value!;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDropdown(
              label: 'Thời gian',
              value: _selectedPeriod,
              items: [
                'Tuần này',
                'Tuần trước',
                'Tháng này',
                'Học kỳ này',
                'Năm học này',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPeriod = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
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

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Tổng quan điểm nề nếp'),
          const SizedBox(height: 16),
          _buildScoreOverview(),
          const SizedBox(height: 24),
          _buildSectionTitle('Thống kê vi phạm'),
          const SizedBox(height: 16),
          _buildViolationOverview(),
          const SizedBox(height: 24),
          _buildSectionTitle('Xếp hạng lớp'),
          const SizedBox(height: 16),
          _buildClassRanking(),
        ],
      ),
    );
  }

  Widget _buildDisciplineTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Điểm nề nếp theo tiêu chí'),
          const SizedBox(height: 16),
          _buildCriteriaScores(),
          const SizedBox(height: 24),
          _buildSectionTitle('Điểm nề nếp theo tuần'),
          const SizedBox(height: 16),
          _buildWeeklyScores(),
        ],
      ),
    );
  }

  Widget _buildViolationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Vi phạm theo loại'),
          const SizedBox(height: 16),
          _buildViolationByType(),
          const SizedBox(height: 24),
          _buildSectionTitle('Vi phạm theo lớp'),
          const SizedBox(height: 16),
          _buildViolationByClass(),
          const SizedBox(height: 24),
          _buildSectionTitle('Vi phạm gần đây'),
          const SizedBox(height: 16),
          _buildRecentViolations(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimaryColor,
      ),
    );
  }

  Widget _buildScoreOverview() {
    return Row(
      children: [
        Expanded(
          child: StatusCard(
            icon: Icons.star,
            title: 'Điểm trung bình',
            value: '85/100',
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatusCard(
            icon: Icons.trending_up,
            title: 'Xu hướng',
            value: '+5% so với tuần trước',
            color: AppTheme.successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildViolationOverview() {
    return Row(
      children: [
        Expanded(
          child: StatusCard(
            icon: Icons.warning_amber_rounded,
            title: 'Tổng số vi phạm',
            value: '15 vi phạm',
            color: AppTheme.warningColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatusCard(
            icon: Icons.trending_down,
            title: 'Xu hướng',
            value: '-10% so với tuần trước',
            color: AppTheme.successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildClassRanking() {
    // Giả lập dữ liệu xếp hạng lớp
    final List<Map<String, dynamic>> rankings = [
      {'rank': 1, 'class': '10A1', 'score': 95, 'change': 0},
      {'rank': 2, 'class': '11A2', 'score': 92, 'change': 1},
      {'rank': 3, 'class': '12A1', 'score': 90, 'change': -1},
      {'rank': 4, 'class': '10A2', 'score': 88, 'change': 0},
      {'rank': 5, 'class': '11A1', 'score': 85, 'change': 2},
      {'rank': 6, 'class': '12A2', 'score': 82, 'change': -2},
    ];

    return CustomCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Hạng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Lớp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Điểm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Thay đổi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rankings.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final ranking = rankings[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${ranking['rank']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ranking['rank'] <= 3
                              ? AppTheme.primaryColor
                              : AppTheme.textPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${ranking['class']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${ranking['score']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildRankChange(ranking['change']),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRankChange(int change) {
    IconData icon;
    Color color;
    String text;

    if (change > 0) {
      icon = Icons.arrow_upward;
      color = AppTheme.successColor;
      text = '+$change';
    } else if (change < 0) {
      icon = Icons.arrow_downward;
      color = AppTheme.errorColor;
      text = '$change';
    } else {
      icon = Icons.remove;
      color = AppTheme.textSecondaryColor;
      text = '0';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCriteriaScores() {
    // Giả lập dữ liệu điểm theo tiêu chí
    final List<Map<String, dynamic>> criteriaScores = [
      {
        'category': AppConstants.attendanceCriteria,
        'score': 18,
        'maxScore': 20,
        'percentage': 90,
      },
      {
        'category': AppConstants.uniformCriteria,
        'score': 14,
        'maxScore': 15,
        'percentage': 93,
      },
      {
        'category': AppConstants.behaviorCriteria,
        'score': 17,
        'maxScore': 20,
        'percentage': 85,
      },
      {
        'category': AppConstants.cleaningCriteria,
        'score': 13,
        'maxScore': 15,
        'percentage': 87,
      },
      {
        'category': AppConstants.learningCriteria,
        'score': 25,
        'maxScore': 30,
        'percentage': 83,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: criteriaScores.length,
      itemBuilder: (context, index) {
        final criteria = criteriaScores[index];
        return CustomCard(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      criteria['category'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    Text(
                      '${criteria['score']}/${criteria['maxScore']} điểm',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: criteria['percentage'] / 100,
                  backgroundColor: AppTheme.backgroundGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Text(
                  '${criteria['percentage']}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondaryColor,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeeklyScores() {
    // Giả lập dữ liệu điểm theo tuần
    final List<Map<String, dynamic>> weeklyScores = [
      {'week': 'Tuần 20 (12/06 - 18/06/2023)', 'score': 85, 'change': 5},
      {'week': 'Tuần 19 (05/06 - 11/06/2023)', 'score': 80, 'change': -2},
      {'week': 'Tuần 18 (29/05 - 04/06/2023)', 'score': 82, 'change': 3},
      {'week': 'Tuần 17 (22/05 - 28/05/2023)', 'score': 79, 'change': 1},
    ];

    return CustomCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Tuần',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Điểm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Thay đổi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weeklyScores.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final weekScore = weeklyScores[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        weekScore['week'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${weekScore['score']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildScoreChange(weekScore['change']),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChange(int change) {
    IconData icon;
    Color color;
    String text;

    if (change > 0) {
      icon = Icons.arrow_upward;
      color = AppTheme.successColor;
      text = '+$change';
    } else if (change < 0) {
      icon = Icons.arrow_downward;
      color = AppTheme.errorColor;
      text = '$change';
    } else {
      icon = Icons.remove;
      color = AppTheme.textSecondaryColor;
      text = '0';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildViolationByType() {
    // Giả lập dữ liệu vi phạm theo loại
    final List<Map<String, dynamic>> violationTypes = [
      {'type': 'Đi học trễ', 'count': 8, 'percentage': 53},
      {'type': 'Không mặc đồng phục', 'count': 4, 'percentage': 27},
      {'type': 'Sử dụng điện thoại trong giờ học', 'count': 2, 'percentage': 13},
      {'type': 'Khác', 'count': 1, 'percentage': 7},
    ];

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Loại vi phạm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                Text(
                  'Số lượng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: violationTypes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final violationType = violationTypes[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          violationType['type'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        Text(
                          '${violationType['count']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: violationType['percentage'] / 100,
                      backgroundColor: AppTheme.backgroundGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.errorColor),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${violationType['percentage']}%',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViolationByClass() {
    // Giả lập dữ liệu vi phạm theo lớp
    final List<Map<String, dynamic>> violationByClass = [
      {'class': '10A1', 'count': 2},
      {'class': '10A2', 'count': 3},
      {'class': '11A1', 'count': 5},
      {'class': '11A2', 'count': 1},
      {'class': '12A1', 'count': 3},
      {'class': '12A2', 'count': 1},
    ];

    return CustomCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Lớp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Số vi phạm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: violationByClass.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final violation = violationByClass[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        violation['class'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${violation['count']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.errorColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentViolations() {
    // Giả lập dữ liệu vi phạm gần đây
    final List<Map<String, dynamic>> recentViolations = [
      {
        'studentName': 'Trần Văn C',
        'className': '10A1',
        'criteriaName': 'Đi học trễ',
        'date': '15/06/2023',
        'points': -2,
      },
      {
        'studentName': 'Lê Thị D',
        'className': '11A2',
        'criteriaName': 'Không mặc đồng phục',
        'date': '14/06/2023',
        'points': -5,
      },
      {
        'studentName': 'Phạm Văn F',
        'className': '12A1',
        'criteriaName': 'Sử dụng điện thoại trong giờ học',
        'date': '13/06/2023',
        'points': -3,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentViolations.length,
      itemBuilder: (context, index) {
        final violation = recentViolations[index];
        return InfoCard(
          margin: const EdgeInsets.only(bottom: 12),
          title: '${violation['studentName']} - ${violation['className']}',
          subtitle: violation['criteriaName'],
          icon: Icons.warning_amber_rounded,
          iconColor: AppTheme.errorColor,
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.errorColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${violation['points']} điểm',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.errorColor,
              ),
            ),
          ),
          footer: Text(
            'Ngày: ${violation['date']}',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        );
      },
    );
  }

  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xuất báo cáo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chọn định dạng xuất báo cáo:'),
            const SizedBox(height: 16),
            _buildPrintOption(
              icon: Icons.picture_as_pdf,
              title: 'PDF',
              subtitle: 'Xuất báo cáo dạng PDF',
            ),
            const SizedBox(height: 12),
            _buildPrintOption(
              icon: Icons.table_chart,
              title: 'Excel',
              subtitle: 'Xuất báo cáo dạng Excel',
            ),
          ],
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
            text: 'Xuất báo cáo',
            onPressed: () {
              Navigator.pop(context);
              // Xuất báo cáo
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xuất báo cáo thành công'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrintOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Radio(
            value: title,
            groupValue: 'PDF',
            onChanged: (value) {},
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}