class AppConstants {
  // App Info
  static const String appName = 'Quản Lý Nề Nếp';
  static const String appVersion = '1.0.0';
  
  // Screen Titles
  static const String loginTitle = 'Đăng Nhập';
  static const String dashboardTitle = 'Tổng Quan';
  static const String disciplineTitle = 'Chấm Điểm Nề Nếp';
  static const String violationTitle = 'Vi Phạm';
  static const String reportsTitle = 'Báo Cáo Thống Kê';
  static const String classManagementTitle = 'Quản Lý Lớp';
  static const String studentManagementTitle = 'Quản Lý Học Sinh';
  static const String criteriaManagementTitle = 'Quản Lý Tiêu Chí';
  static const String accountManagementTitle = 'Quản Lý Tài Khoản';
  
  // User Roles
  static const String roleAdmin = 'ADMIN'; // Ban giám hiệu
  static const String roleTeacher = 'TEACHER'; // Giáo viên
  static const String roleDisciplineTeam = 'DISCIPLINE_TEAM'; // Ban nề nếp
  
  // Form Labels
  static const String usernameLabel = 'Tên đăng nhập';
  static const String passwordLabel = 'Mật khẩu';
  static const String fullNameLabel = 'Họ và tên';
  static const String emailLabel = 'Email';
  static const String phoneLabel = 'Số điện thoại';
  static const String classLabel = 'Lớp';
  static const String gradeLabel = 'Khối';
  static const String dateLabel = 'Ngày';
  static const String weekLabel = 'Tuần';
  static const String monthLabel = 'Tháng';
  static const String yearLabel = 'Năm học';
  static const String criteriaLabel = 'Tiêu chí';
  static const String pointsLabel = 'Điểm';
  static const String noteLabel = 'Ghi chú';
  
  // Button Labels
  static const String loginButton = 'Đăng Nhập';
  static const String logoutButton = 'Đăng Xuất';
  static const String saveButton = 'Lưu';
  static const String cancelButton = 'Hủy';
  static const String addButton = 'Thêm';
  static const String editButton = 'Sửa';
  static const String deleteButton = 'Xóa';
  static const String confirmButton = 'Xác Nhận';
  static const String rejectButton = 'Từ Chối';
  static const String filterButton = 'Lọc';
  static const String searchButton = 'Tìm Kiếm';
  static const String exportButton = 'Xuất Báo Cáo';
  
  // Messages
  static const String loginSuccess = 'Đăng nhập thành công!';
  static const String loginFailed = 'Đăng nhập thất bại. Vui lòng kiểm tra lại thông tin!';
  static const String saveSuccess = 'Lưu thành công!';
  static const String saveFailed = 'Lưu thất bại!';
  static const String deleteConfirm = 'Bạn có chắc chắn muốn xóa?';
  static const String deleteSuccess = 'Xóa thành công!';
  static const String deleteFailed = 'Xóa thất bại!';
  static const String fieldRequired = 'Vui lòng nhập thông tin này';
  static const String invalidEmail = 'Email không hợp lệ';
  static const String invalidPhone = 'Số điện thoại không hợp lệ';
  static const String passwordTooShort = 'Mật khẩu phải có ít nhất 6 ký tự';
  
  // Discipline Criteria Categories
  static const String attendanceCriteria = 'Chuyên cần';
  static const String uniformCriteria = 'Đồng phục';
  static const String behaviorCriteria = 'Hành vi';
  static const String cleaningCriteria = 'Vệ sinh';
  static const String learningCriteria = 'Học tập';
}