import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';

class ViolationScreen extends StatefulWidget {
  const ViolationScreen({Key? key}) : super(key: key);

  @override
  State<ViolationScreen> createState() => _ViolationScreenState();
}

class _ViolationScreenState extends State<ViolationScreen> {
  final String _userRole = AppConstants.roleHeadmaster; // Giả lập vai trò người dùng
  final String _userName = 'Nguyễn Văn A';
  String _selectedClass = 'Tất cả lớp';
  String _selectedStatus = 'Tất cả trạng thái';
  String _selectedDate = 'Tất cả ngày';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.violationTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddViolationDialog(context);
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        currentRoute: '/violation',
        userRole: _userRole,
        userName: _userName,
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: _buildViolationList(),
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
                  label: 'Trạng thái',
                  value: _selectedStatus,
                  items: [
                    'Tất cả trạng thái',
                    'Chờ xác nhận',
                    'Đã xác nhận',
                    'Đã từ chối',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Ngày',
                  value: _selectedDate,
                  items: [
                    'Tất cả ngày',
                    'Hôm nay',
                    'Tuần này',
                    'Tháng này',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedDate = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: CustomButton(
                    text: 'Tìm kiếm',
                    icon: Icons.search,
                    onPressed: () {
                      // Xử lý tìm kiếm
                    },
                  ),
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

  Widget _buildViolationList() {
    // Giả lập dữ liệu vi phạm
    final List<Map<String, dynamic>> violations = [
      {
        'id': '1',
        'studentName': 'Trần Văn C',
        'studentId': 'HS001',
        'className': '10A1',
        'criteriaName': 'Đi học trễ',
        'points': -2,
        'date': '15/06/2023',
        'reportedBy': 'Nguyễn Văn B',
        'status': 'Chờ xác nhận',
        'note': 'Đi trễ 15 phút',
        'hasImage': true,
      },
      {
        'id': '2',
        'studentName': 'Lê Thị D',
        'studentId': 'HS002',
        'className': '11A2',
        'criteriaName': 'Không mặc đồng phục',
        'points': -5,
        'date': '14/06/2023',
        'reportedBy': 'Trần Thị E',
        'status': 'Đã xác nhận',
        'note': 'Không mặc áo đồng phục đúng quy định',
        'hasImage': false,
      },
      {
        'id': '3',
        'studentName': 'Phạm Văn F',
        'studentId': 'HS003',
        'className': '12A1',
        'criteriaName': 'Sử dụng điện thoại trong giờ học',
        'points': -3,
        'date': '13/06/2023',
        'reportedBy': 'Lê Văn G',
        'status': 'Đã từ chối',
        'note': 'Sử dụng điện thoại khi giáo viên không cho phép',
        'hasImage': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: violations.length,
      itemBuilder: (context, index) {
        final violation = violations[index];
        return _buildViolationItem(violation);
      },
    );
  }

  Widget _buildViolationItem(Map<String, dynamic> violation) {
    Color statusColor;
    IconData statusIcon;

    switch (violation['status']) {
      case 'Chờ xác nhận':
        statusColor = AppTheme.warningColor;
        statusIcon = Icons.pending_outlined;
        break;
      case 'Đã xác nhận':
        statusColor = AppTheme.successColor;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'Đã từ chối':
        statusColor = AppTheme.errorColor;
        statusIcon = Icons.cancel_outlined;
        break;
      default:
        statusColor = AppTheme.textSecondaryColor;
        statusIcon = Icons.help_outline;
    }

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
                      violation['studentName'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mã HS: ${violation['studentId']} - Lớp: ${violation['className']}',
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
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 16,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      violation['status'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
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
                      'Vi phạm:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      violation['criteriaName'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${violation['points']} điểm',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.errorColor,
                  ),
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
                      'Ghi chú:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      violation['note'],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ngày: ${violation['date']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              Text(
                'Người báo cáo: ${violation['reportedBy']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          if (violation['hasImage'])
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.backgroundGrey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.dividerColor),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.image,
                      size: 32,
                      color: AppTheme.textSecondaryColor,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hình ảnh vi phạm',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (violation['status'] == 'Chờ xác nhận' && _userRole == AppConstants.roleHeadmaster)
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Từ chối',
                    type: ButtonType.outline,
                    onPressed: () {
                      _showRejectDialog(context, violation);
                    },
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    text: 'Xác nhận',
                    onPressed: () {
                      _showConfirmDialog(context, violation);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showAddViolationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm vi phạm mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField(
                label: 'Lớp',
                items: ['10A1', '10A2', '11A1', '11A2', '12A1', '12A2'],
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Học sinh',
                items: ['Trần Văn C', 'Lê Thị D', 'Phạm Văn F'],
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Loại vi phạm',
                items: [
                  'Đi học trễ',
                  'Không mặc đồng phục',
                  'Sử dụng điện thoại trong giờ học',
                  'Không hoàn thành bài tập',
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(label: 'Điểm trừ', hintText: 'Nhập số điểm trừ'),
              const SizedBox(height: 16),
              _buildTextField(
                  label: 'Ghi chú', hintText: 'Nhập ghi chú về vi phạm'),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hình ảnh (nếu có)',
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
                            'Thêm hình ảnh',
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
            text: AppConstants.saveButton,
            onPressed: () {
              Navigator.pop(context);
              // Lưu vi phạm mới
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã thêm vi phạm mới thành công'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, Map<String, dynamic> violation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận vi phạm'),
        content: Text(
            'Bạn có chắc chắn muốn xác nhận vi phạm của học sinh ${violation['studentName']} không?'),
        actions: [
          CustomButton(
            text: AppConstants.cancelButton,
            type: ButtonType.outline,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            text: 'Xác nhận',
            onPressed: () {
              Navigator.pop(context);
              // Xác nhận vi phạm
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xác nhận vi phạm thành công'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, Map<String, dynamic> violation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Từ chối vi phạm'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Bạn có chắc chắn muốn từ chối vi phạm của học sinh ${violation['studentName']} không?'),
            const SizedBox(height: 16),
            _buildTextField(
                label: 'Lý do từ chối', hintText: 'Nhập lý do từ chối'),
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
            text: 'Từ chối',
            onPressed: () {
              Navigator.pop(context);
              // Từ chối vi phạm
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã từ chối vi phạm thành công'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
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
            value: items.first,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
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
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}