import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';
import 'package:quanlynenep/widgets/common/custom_text_field.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({Key? key}) : super(key: key);

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  final String _userRole = AppConstants.roleAdmin; // Giả lập vai trò người dùng
  final String _userName = 'Admin';
  String _searchQuery = '';
  String _selectedClass = 'Tất cả lớp';
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
        title: const Text(AppConstants.studentManagementTitle),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        currentRoute: '/management/student',
        userRole: _userRole,
        userName: _userName,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildStudentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditStudentDialog(context);
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
                  hintText: 'Tìm kiếm học sinh...',
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
              value: _selectedClass,
              isExpanded: true,
              underline: const SizedBox(),
              items: [
                'Tất cả lớp',
                '10A1',
                '10A2',
                '11A1',
                '11A2',
                '12A1',
                '12A2',
              ].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedClass = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    // Giả lập dữ liệu học sinh
    final List<Map<String, dynamic>> students = [
      {
        'id': '1',
        'studentId': 'HS001',
        'fullName': 'Trần Văn C',
        'className': '10A1',
        'dateOfBirth': '15/05/2007',
        'gender': 'Nam',
        'address': '123 Đường ABC, Quận 1, TP.HCM',
        'parentName': 'Trần Văn B',
        'parentPhone': '0901234567',
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '2',
        'studentId': 'HS002',
        'fullName': 'Lê Thị D',
        'className': '10A1',
        'dateOfBirth': '20/06/2007',
        'gender': 'Nữ',
        'address': '456 Đường XYZ, Quận 2, TP.HCM',
        'parentName': 'Lê Văn E',
        'parentPhone': '0912345678',
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '3',
        'studentId': 'HS003',
        'fullName': 'Phạm Văn F',
        'className': '11A1',
        'dateOfBirth': '10/03/2006',
        'gender': 'Nam',
        'address': '789 Đường DEF, Quận 3, TP.HCM',
        'parentName': 'Phạm Văn G',
        'parentPhone': '0923456789',
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '4',
        'studentId': 'HS004',
        'fullName': 'Nguyễn Thị H',
        'className': '11A2',
        'dateOfBirth': '25/08/2006',
        'gender': 'Nữ',
        'address': '101 Đường GHI, Quận 4, TP.HCM',
        'parentName': 'Nguyễn Văn I',
        'parentPhone': '0934567890',
        'avatar': null,
        'isActive': true,
      },
      {
        'id': '5',
        'studentId': 'HS005',
        'fullName': 'Hoàng Văn J',
        'className': '12A1',
        'dateOfBirth': '05/11/2005',
        'gender': 'Nam',
        'address': '202 Đường JKL, Quận 5, TP.HCM',
        'parentName': 'Hoàng Văn K',
        'parentPhone': '0945678901',
        'avatar': null,
        'isActive': true,
      },
    ];

    // Lọc học sinh theo từ khóa tìm kiếm và lớp
    final filteredStudents = students.where((student) {
      final matchesSearch = student['fullName']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          student['studentId']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesClass = _selectedClass == 'Tất cả lớp' ||
          student['className'] == _selectedClass;

      return matchesSearch && matchesClass;
    }).toList();

    if (filteredStudents.isEmpty) {
      return const Center(
        child: Text(
          'Không tìm thấy học sinh nào',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        return _buildStudentItem(student);
      },
    );
  }

  Widget _buildStudentItem(Map<String, dynamic> student) {
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
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    student['fullName'].substring(0, 1),
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
                      student['fullName'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mã HS: ${student['studentId']} - Lớp: ${student['className']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: student['isActive'],
                onChanged: (value) {
                  // Cập nhật trạng thái hoạt động của học sinh
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
                      'Ngày sinh',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student['dateOfBirth'],
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
                      'Giới tính',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student['gender'],
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
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Địa chỉ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                student['address'],
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phụ huynh',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student['parentName'],
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
                      student['parentPhone'],
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Xem',
                icon: Icons.visibility,
                type: ButtonType.text,
                onPressed: () {
                  // Xem chi tiết học sinh
                },
              ),
              CustomButton(
                text: 'Sửa',
                icon: Icons.edit,
                type: ButtonType.text,
                onPressed: () {
                  _showAddEditStudentDialog(context, student: student);
                },
              ),
              CustomButton(
                text: 'Xóa',
                icon: Icons.delete,
                type: ButtonType.text,
                textColor: AppTheme.errorColor,
                iconColor: AppTheme.errorColor,
                onPressed: () {
                  _showDeleteConfirmationDialog(context, student);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddEditStudentDialog(BuildContext context, {Map<String, dynamic>? student}) {
    final bool isEditing = student != null;
    final TextEditingController studentIdController =
        TextEditingController(text: isEditing ? student['studentId'] : '');
    final TextEditingController fullNameController =
        TextEditingController(text: isEditing ? student['fullName'] : '');
    final TextEditingController dateOfBirthController =
        TextEditingController(text: isEditing ? student['dateOfBirth'] : '');
    final TextEditingController addressController =
        TextEditingController(text: isEditing ? student['address'] : '');
    final TextEditingController parentNameController =
        TextEditingController(text: isEditing ? student['parentName'] : '');
    final TextEditingController parentPhoneController =
        TextEditingController(text: isEditing ? student['parentPhone'] : '');

    String selectedClass = isEditing ? student['className'] : '10A1';
    String selectedGender = isEditing ? student['gender'] : 'Nam';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Sửa thông tin học sinh' : 'Thêm học sinh mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: studentIdController,
                labelText: 'Mã học sinh',
                hintText: 'Nhập mã học sinh',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã học sinh';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: fullNameController,
                labelText: 'Họ và tên',
                hintText: 'Nhập họ và tên học sinh',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ và tên học sinh';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Lớp',
                value: selectedClass,
                items: ['10A1', '10A2', '11A1', '11A2', '12A1', '12A2'],
                onChanged: (value) {
                  selectedClass = value!;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: dateOfBirthController,
                labelText: 'Ngày sinh',
                hintText: 'Nhập ngày sinh (DD/MM/YYYY)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập ngày sinh';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Giới tính',
                value: selectedGender,
                items: ['Nam', 'Nữ'],
                onChanged: (value) {
                  selectedGender = value!;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: addressController,
                labelText: 'Địa chỉ',
                hintText: 'Nhập địa chỉ',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: parentNameController,
                labelText: 'Tên phụ huynh',
                hintText: 'Nhập tên phụ huynh',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên phụ huynh';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: parentPhoneController,
                labelText: 'Số điện thoại phụ huynh',
                hintText: 'Nhập số điện thoại phụ huynh',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại phụ huynh';
                  }
                  return null;
                },
              ),
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
              // Lưu thông tin học sinh
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isEditing
                      ? 'Đã cập nhật thông tin học sinh'
                      : 'Đã thêm học sinh mới'),
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
      BuildContext context, Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text(
            'Bạn có chắc chắn muốn xóa học sinh ${student['fullName']} không? Hành động này không thể hoàn tác.'),
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
              // Xóa học sinh
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa học sinh'),
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
        title: const Text('Lọc học sinh'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('Khối', ['Tất cả', '10', '11', '12']),
            const SizedBox(height: 16),
            _buildFilterOption('Giới tính', ['Tất cả', 'Nam', 'Nữ']),
            const SizedBox(height: 16),
            _buildFilterOption('Trạng thái', ['Tất cả', 'Đang học', 'Đã nghỉ']),
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