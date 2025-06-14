import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';
import 'package:quanlynenep/widgets/common/custom_text_field.dart';

class ClassManagementScreen extends StatefulWidget {
  const ClassManagementScreen({Key? key}) : super(key: key);

  @override
  State<ClassManagementScreen> createState() => _ClassManagementScreenState();
}

class _ClassManagementScreenState extends State<ClassManagementScreen> {
  final String _userRole = AppConstants.roleAdmin; // Giả lập vai trò người dùng
  final String _userName = 'Admin';
  String _searchQuery = '';
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
        title: const Text(AppConstants.classManagementTitle),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        currentRoute: '/management/class',
        userRole: _userRole,
        userName: _userName,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildClassList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditClassDialog(context);
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
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _searchController,
              hint: 'Tìm kiếm lớp học...',
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
    );
  }

  Widget _buildClassList() {
    // Giả lập dữ liệu lớp học
    final List<Map<String, dynamic>> classes = [
      {
        'id': '1',
        'className': '10A1',
        'grade': '10',
        'homeTeacherName': 'Nguyễn Văn B',
        'studentCount': 35,
        'schoolYear': '2022-2023',
        'isActive': true,
      },
      {
        'id': '2',
        'className': '10A2',
        'grade': '10',
        'homeTeacherName': 'Trần Thị C',
        'studentCount': 32,
        'schoolYear': '2022-2023',
        'isActive': true,
      },
      {
        'id': '3',
        'className': '11A1',
        'grade': '11',
        'homeTeacherName': 'Lê Văn D',
        'studentCount': 30,
        'schoolYear': '2022-2023',
        'isActive': true,
      },
      {
        'id': '4',
        'className': '11A2',
        'grade': '11',
        'homeTeacherName': 'Phạm Thị E',
        'studentCount': 33,
        'schoolYear': '2022-2023',
        'isActive': true,
      },
      {
        'id': '5',
        'className': '12A1',
        'grade': '12',
        'homeTeacherName': 'Hoàng Văn F',
        'studentCount': 28,
        'schoolYear': '2022-2023',
        'isActive': true,
      },
      {
        'id': '6',
        'className': '12A2',
        'grade': '12',
        'homeTeacherName': 'Ngô Thị G',
        'studentCount': 30,
        'schoolYear': '2022-2023',
        'isActive': true,
      },
    ];

    // Lọc lớp học theo từ khóa tìm kiếm
    final filteredClasses = classes.where((classItem) {
      return classItem['className']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          classItem['homeTeacherName']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();

    if (filteredClasses.isEmpty) {
      return const Center(
        child: Text(
          'Không tìm thấy lớp học nào',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredClasses.length,
      itemBuilder: (context, index) {
        final classItem = filteredClasses[index];
        return _buildClassItem(classItem);
      },
    );
  }

  Widget _buildClassItem(Map<String, dynamic> classItem) {
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
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    classItem['grade'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
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
                      classItem['className'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Năm học: ${classItem['schoolYear']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: classItem['isActive'],
                onChanged: (value) {
                  // Cập nhật trạng thái hoạt động của lớp
                },
                activeColor: AppTheme.primaryColor,
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Giáo viên chủ nhiệm',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      classItem['homeTeacherName'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
                      'Sĩ số',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${classItem['studentCount']} học sinh',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Xem',
                icon: Icons.visibility,
                type: ButtonType.text,
                onPressed: () {
                  // Xem chi tiết lớp học
                },
              ),
              CustomButton(
                text: 'Sửa',
                icon: Icons.edit,
                type: ButtonType.text,
                onPressed: () {
                  _showAddEditClassDialog(context, classItem: classItem);
                },
              ),
              CustomButton(
                text: 'Xóa',
                icon: Icons.delete,
                type: ButtonType.text,
                textColor: AppTheme.errorColor,
                onPressed: () {
                  _showDeleteConfirmationDialog(context, classItem);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddEditClassDialog(BuildContext context, {Map<String, dynamic>? classItem}) {
    final bool isEditing = classItem != null;
    final TextEditingController classNameController =
        TextEditingController(text: isEditing ? classItem['className'] : '');
    final TextEditingController gradeController =
        TextEditingController(text: isEditing ? classItem['grade'] : '');
    final TextEditingController homeTeacherController = TextEditingController(
        text: isEditing ? classItem['homeTeacherName'] : '');
    final TextEditingController schoolYearController =
        TextEditingController(text: isEditing ? classItem['schoolYear'] : '2022-2023');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Sửa lớp học' : 'Thêm lớp học mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: classNameController,
                label: 'Tên lớp',
                hint: 'Nhập tên lớp (VD: 10A1)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên lớp';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: gradeController,
                label: 'Khối',
                hint: 'Nhập khối (VD: 10)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập khối';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: homeTeacherController,
                label: 'Giáo viên chủ nhiệm',
                hint: 'Nhập tên giáo viên chủ nhiệm',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên giáo viên chủ nhiệm';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: schoolYearController,
                label: 'Năm học',
                hint: 'Nhập năm học (VD: 2022-2023)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập năm học';
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
            text: isEditing ? 'Cập nhật' : 'Thêm mới',
            onPressed: () {
              Navigator.pop(context);
              // Lưu thông tin lớp học
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isEditing
                      ? 'Đã cập nhật thông tin lớp học'
                      : 'Đã thêm lớp học mới'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, dynamic> classItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text(
            'Bạn có chắc chắn muốn xóa lớp ${classItem['className']} không? Hành động này không thể hoàn tác.'),
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
              // Xóa lớp học
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa lớp học'),
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
        title: const Text('Lọc lớp học'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('Khối', ['Tất cả', '10', '11', '12']),
            const SizedBox(height: 16),
            _buildFilterOption(
                'Năm học', ['Tất cả', '2022-2023', '2021-2022', '2020-2021']),
            const SizedBox(height: 16),
            _buildFilterOption('Trạng thái', ['Tất cả', 'Đang hoạt động', 'Không hoạt động']),
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