import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';

class DisciplineScreen extends StatefulWidget {
  const DisciplineScreen({Key? key}) : super(key: key);

  @override
  State<DisciplineScreen> createState() => _DisciplineScreenState();
}

class _DisciplineScreenState extends State<DisciplineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _userRole = AppConstants.roleDisciplineTeam; // Giả lập vai trò người dùng
  final String _userName = 'Nguyễn Văn B';
  String _selectedClass = 'Tất cả lớp';
  String _selectedWeek = 'Tuần 20 (12/06 - 18/06/2023)';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        title: const Text(AppConstants.disciplineTitle),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: AppConstants.attendanceCriteria),
            Tab(text: AppConstants.uniformCriteria),
            Tab(text: AppConstants.behaviorCriteria),
            Tab(text: AppConstants.cleaningCriteria),
            Tab(text: AppConstants.learningCriteria),
          ],
        ),
      ),
      drawer: AppDrawer(
        currentRoute: '/discipline',
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
                _buildCriteriaList(AppConstants.attendanceCriteria),
                _buildCriteriaList(AppConstants.uniformCriteria),
                _buildCriteriaList(AppConstants.behaviorCriteria),
                _buildCriteriaList(AppConstants.cleaningCriteria),
                _buildCriteriaList(AppConstants.learningCriteria),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSaveConfirmationDialog();
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.save),
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
      child: Column(
        children: [
          Row(
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
                  label: 'Tuần',
                  value: _selectedWeek,
                  items: [
                    'Tuần 20 (12/06 - 18/06/2023)',
                    'Tuần 19 (05/06 - 11/06/2023)',
                    'Tuần 18 (29/05 - 04/06/2023)',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedWeek = value!;
                    });
                  },
                ),
              ),
            ],
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

  Widget _buildCriteriaList(String category) {
    // Giả lập dữ liệu tiêu chí
    final List<Map<String, dynamic>> criteriaList = _getCriteriaByCategory(category);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: criteriaList.length,
      itemBuilder: (context, index) {
        final criteria = criteriaList[index];
        return _buildCriteriaItem(criteria);
      },
    );
  }

  Widget _buildCriteriaItem(Map<String, dynamic> criteria) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      criteria['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      criteria['description'],
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
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Tối đa: ${criteria['maxPoints']} điểm',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Điểm đạt được:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildPointsSelector(criteria),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ghi chú:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Nhập ghi chú (nếu có)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointsSelector(Map<String, dynamic> criteria) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              // Giảm điểm
            },
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                criteria['points'].toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Tăng điểm
            },
          ),
        ],
      ),
    );
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận lưu'),
        content: const Text(
            'Bạn có chắc chắn muốn lưu điểm nề nếp cho lớp $_selectedClass không?'),
        actions: [
          CustomButton(
            text: AppConstants.cancelButton,
            type: ButtonType.outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            text: AppConstants.saveButton,
            onPressed: () {
              Navigator.pop(context);
              // Lưu điểm nề nếp
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppConstants.saveSuccess),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getCriteriaByCategory(String category) {
    // Giả lập dữ liệu tiêu chí theo danh mục
    switch (category) {
      case AppConstants.attendanceCriteria:
        return [
          {
            'id': '1',
            'name': 'Đi học đầy đủ',
            'description': 'Học sinh đi học đầy đủ, không nghỉ học không phép',
            'maxPoints': 10,
            'points': 10,
          },
          {
            'id': '2',
            'name': 'Đi học đúng giờ',
            'description': 'Học sinh đi học đúng giờ, không đi trễ',
            'maxPoints': 5,
            'points': 5,
          },
        ];
      case AppConstants.uniformCriteria:
        return [
          {
            'id': '3',
            'name': 'Đồng phục đúng quy định',
            'description': 'Học sinh mặc đồng phục đúng quy định của trường',
            'maxPoints': 10,
            'points': 10,
          },
          {
            'id': '4',
            'name': 'Đeo thẻ học sinh',
            'description': 'Học sinh đeo thẻ học sinh đầy đủ',
            'maxPoints': 5,
            'points': 5,
          },
        ];
      case AppConstants.behaviorCriteria:
        return [
          {
            'id': '5',
            'name': 'Ứng xử văn minh',
            'description': 'Học sinh có thái độ, hành vi, ngôn ngữ văn minh, lịch sự',
            'maxPoints': 10,
            'points': 10,
          },
          {
            'id': '6',
            'name': 'Tham gia hoạt động',
            'description': 'Học sinh tích cực tham gia các hoạt động của trường, lớp',
            'maxPoints': 10,
            'points': 8,
          },
        ];
      case AppConstants.cleaningCriteria:
        return [
          {
            'id': '7',
            'name': 'Vệ sinh lớp học',
            'description': 'Lớp học sạch sẽ, gọn gàng',
            'maxPoints': 10,
            'points': 9,
          },
          {
            'id': '8',
            'name': 'Bảo quản tài sản',
            'description': 'Bảo quản tốt tài sản, thiết bị của lớp và trường',
            'maxPoints': 5,
            'points': 5,
          },
        ];
      case AppConstants.learningCriteria:
        return [
          {
            'id': '9',
            'name': 'Học tập tích cực',
            'description': 'Học sinh tích cực học tập, hoàn thành bài tập',
            'maxPoints': 10,
            'points': 8,
          },
          {
            'id': '10',
            'name': 'Kỷ luật trong giờ học',
            'description': 'Học sinh giữ trật tự, kỷ luật trong giờ học',
            'maxPoints': 10,
            'points': 9,
          },
        ];
      default:
        return [];
    }
  }
}