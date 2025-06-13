class Validators {
  // Kiểm tra email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  // Kiểm tra số điện thoại
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    final phoneRegex = RegExp(r'^(0|\+84)[3|5|7|8|9][0-9]{8}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  // Kiểm tra mật khẩu
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  // Kiểm tra trường bắt buộc
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập ${fieldName ?? 'thông tin này'}';
    }
    return null;
  }

  // Kiểm tra số
  static String? validateNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập ${fieldName ?? 'số'}';
    }
    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'Giá trị'} phải là số';
    }
    return null;
  }

  // Kiểm tra số trong khoảng
  static String? validateNumberRange(String? value,
      {required int min, required int max, String? fieldName}) {
    final numberError = validateNumber(value, fieldName: fieldName);
    if (numberError != null) {
      return numberError;
    }

    final number = int.parse(value!);
    if (number < min || number > max) {
      return '${fieldName ?? 'Giá trị'} phải từ $min đến $max';
    }
    return null;
  }
}