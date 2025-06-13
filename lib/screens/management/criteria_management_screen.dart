import 'package:flutter/material.dart';
import 'package:quanlynenep/constants/app_constants.dart';
import 'package:quanlynenep/constants/app_theme.dart';
import 'package:quanlynenep/widgets/common/app_drawer.dart';
import 'package:quanlynenep/widgets/common/custom_button.dart';
import 'package:quanlynenep/widgets/common/custom_card.dart';
import 'package:quanlynenep/widgets/common/custom_text_field.dart';

class CriteriaManagementScreen extends StatefulWidget {
  const CriteriaManagementScreen({Key? key}) : super(key: key);

  @override
  State<CriteriaManagementScreen> createState() => _CriteriaManagementScreenState();
}

class _CriteriaManagementScreenState extends State<CriteriaManagementScreen>
    with SingleTickerProviderStateMixin {
  final String _userRole = AppConstants.roleAdmin; // Giả lập vai trò người dùng
  final String _userName = 'Admin';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.criteriaManagementTitle),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Tất cả'),
            Tab(text: AppConstants.disciplineCategoryNeatness),
            Tab(text: AppConstants.disciplineCategoryLearning),
            Tab(text: AppConstants.disciplineCategoryOther),
          ],
        ),
      ),
      drawer: AppDrawer(
        currentRoute: '/management/criteria',
        userRole: _userRole,
        userName: _userName,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCriteriaList('all'),
                _buildCriteriaList(AppConstants.disciplineCategoryNeatness),
                _buildCriteriaList(AppConstants.disciplineCategoryLearning),
                _buildCriteriaList(AppConstants.disciplineCategoryOther),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditCriteriaDialog(context);
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
              hintText: 'Tìm kiếm tiêu chí...',
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

  Widget _buildCriteriaList(String category) {
    // Giả lập dữ liệu tiêu chí
    final List<Map<String, dynamic>> allCriteria = [
      {
        'id': '1',
        'name': 'Vệ sinh lớp học',
        'category': AppConstants.disciplineCategoryNeatness,
        'description': 'Đánh giá tình trạng vệ sinh của lớp học',
        'maxPoints': 10,
        'minPoints': 0,
        'isViolation': false,
        'isActive': true,
      },
      {
        'id': '2',
        'name': 'Trang phục học sinh',
        'category': AppConstants.disciplineCategoryNeatness,
        'description': 'Đánh giá việc mặc đồng phục đúng quy định',
        'maxPoints': 10,
        'minPoints': 0,
        'isViolation': false,
        'isActive': true,
      },
      {
        'id': '3',
        'name': 'Đi học đúng giờ',
        'category': AppConstants.disciplineCategoryLearning,
        'description': 'Đánh giá việc đi học đúng giờ của học sinh',
        'maxPoints': 10,
        'minPoints': 0,
        'isViolation': false,
        'isActive': true,
      },
      {
        'id': '4',
        'name': 'Nộp bài tập đầy đủ',
        'category': AppConstants.disciplineCategoryLearning,
        'description': 'Đánh giá việc nộp bài tập đầy đủ và đúng hạn',
        'maxPoints': 10,
        'minPoints': 0,
        'isViolation': false,
        'isActive': true,
      },
      {
        'id': '5',
        'name': 'Tham gia hoạt động ngoại khóa',
        'category': AppConstants.disciplineCategoryOther,
        'description': 'Đánh giá mức độ tham gia các hoạt động ngoại khóa',
        'maxPoints': 10,
        'minPoints': 0,
        'isViolation': false,
        'isActive': true,
      },
      {
        'id': '6',
        'name': 'Hút thuốc trong trường',
        'category': AppConstants.disciplineCategoryNeatness,
        'description': 'Vi phạm hút thuốc trong khuôn viên trường',
        'maxPoints': -10,
        'minPoints': -10,
        'isViolation': true,
        'isActive': true,
      },
      {
        'id': '7',
        'name': 'Đánh nhau',
        'category': AppConstants.disciplineCategoryOther,
        'description': 'Vi phạm đánh nhau trong trường học',
        'maxPoints': -20,
        'minPoints': -20,
        'isViolation': true,
        'isActive': true,
      },
    ];

    // Lọc tiêu chí theo danh mục và từ khóa tìm kiếm
    final filteredCriteria = allCriteria.where((criteria) {
      final matchesCategory = category == 'all' ||
          criteria['category'].toString().toLowerCase() ==
              category.toLowerCase();

      final matchesSearch = criteria['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    if (filteredCriteria.isEmpty) {
      return const Center(
        child: Text(
          'Không tìm thấy tiêu chí nào',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredCriteria.length,
      itemBuilder: (context, index) {
        final criteria = filteredCriteria[index];
        return _buildCriteriaItem(criteria);
      },
    );
  }

  Widget _buildCriteriaItem(Map<String, dynamic> criteria) {
    final bool isViolation = criteria['isViolation'] ?? false;
    final Color categoryColor = _getCategoryColor(criteria['category']);

    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 48,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 16),
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
                      criteria['category'],
                      style: TextStyle(
                        fontSize: 14,
                        color: categoryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isViolation
                      ? AppTheme.errorColor.withOpacity(0.1)
                      : AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  isViolation ? 'Vi phạm' : 'Tiêu chí',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isViolation ? AppTheme.errorColor : AppTheme.successColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: criteria['isActive'],
                onChanged: (value) {
                  // Cập nhật trạng thái hoạt động của tiêu chí
                },
                activeColor: AppTheme.primaryColor,
              ),
            ],
          ),
          const Divider(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mô tả',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  criteria['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Điểm tối đa',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${criteria['maxPoints']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isViolation
                                  ? AppTheme.errorColor
                                  : AppTheme.successColor,
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
                            'Điểm tối thiểu',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${criteria['minPoints']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isViolation
                                  ? AppTheme.errorColor
                                  : AppTheme.successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Sửa',
                icon: Icons.edit,
                type: ButtonType.text,
                onPressed: () {
                  _showAddEditCriteriaDialog(context, criteria: criteria);
                },
              ),
              CustomButton(
                text: 'Xóa',
                icon: Icons.delete,
                type: ButtonType.text,
                textColor: AppTheme.errorColor,
                iconColor: AppTheme.errorColor,
                onPressed: () {
                  _showDeleteConfirmationDialog(context, criteria);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case AppConstants.disciplineCategoryNeatness:
        return Colors.blue;
      case AppConstants.disciplineCategoryLearning:
        return Colors.green;
      case AppConstants.disciplineCategoryOther:
        return Colors.purple;
      default:
        return AppTheme.primaryColor;
    }
  }

  void _showAddEditCriteriaDialog(BuildContext context,
      {Map<String, dynamic>? criteria}) {
    final bool isEditing = criteria != null;
    final TextEditingController nameController =
        TextEditingController(text: isEditing ? criteria['name'] : '');
    final TextEditingController descriptionController =
        TextEditingController(text: isEditing ? criteria['description'] : '');
    final TextEditingController maxPointsController = TextEditingController(
        text: isEditing ? criteria['maxPoints'].toString() : '10');
    final TextEditingController minPointsController = TextEditingController(
        text: isEditing ? criteria['minPoints'].toString() : '0');

    String selectedCategory = isEditing
        ? criteria['category']
        : AppConstants.disciplineCategoryNeatness;
    bool isViolation = isEditing ? criteria['isViolation'] : false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Sửa tiêu chí' : 'Thêm tiêu chí mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameController,
                labelText: 'Tên tiêu chí',
                hintText: 'Nhập tên tiêu chí',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên tiêu chí';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Danh mục',
                value: selectedCategory,
                items: [
                  AppConstants.disciplineCategoryNeatness,
                  AppConstants.disciplineCategoryLearning,
                  AppConstants.disciplineCategoryOther,
                ],
                onChanged: (value) {
                  selectedCategory = value!;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: descriptionController,
                labelText: 'Mô tả',
                hintText: 'Nhập mô tả tiêu chí',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả tiêu chí';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: maxPointsController,
                      labelText: 'Điểm tối đa',
                      hintText: 'Nhập điểm tối đa',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập điểm tối đa';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: minPointsController,
                      labelText: 'Điểm tối thiểu',
                      hintText: 'Nhập điểm tối thiểu',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập điểm tối thiểu';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Là vi phạm:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: isViolation,
                    onChanged: (value) {
                      isViolation = value;
                      if (value) {
                        // Nếu là vi phạm, đặt điểm tối đa và tối thiểu là số âm
                        maxPointsController.text = '-10';
                        minPointsController.text = '-10';
                      } else {
                        // Nếu không phải vi phạm, đặt điểm tối đa và tối thiểu là số dương
                        maxPointsController.text = '10';
                        minPointsController.text = '0';
                      }
                    },
                    activeColor: AppTheme.primaryColor,
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
              // Lưu thông tin tiêu chí
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isEditing
                      ? 'Đã cập nhật tiêu chí'
                      : 'Đã thêm tiêu chí mới'),
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
      BuildContext context, Map<String, dynamic> criteria) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text(
            'Bạn có chắc chắn muốn xóa tiêu chí "${criteria['name']}" không? Hành động này không thể hoàn tác.'),
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
              // Xóa tiêu chí
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa tiêu chí'),
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
        title: const Text('Lọc tiêu chí'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('Loại tiêu chí', ['Tất cả', 'Tiêu chí', 'Vi phạm']),
            const SizedBox(height: 16),
            _buildFilterOption('Trạng thái',
                ['Tất cả', 'Đang sử dụng', 'Không sử dụng']),
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