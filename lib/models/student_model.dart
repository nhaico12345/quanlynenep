class StudentModel {
  final String id;
  final String studentId; // Mã học sinh
  final String fullName;
  final String classId; // ID của lớp
  final String className; // Tên lớp
  final String? dateOfBirth;
  final String? gender; // Nam/Nữ
  final String? address;
  final String? parentName; // Tên phụ huynh
  final String? parentPhone; // SĐT phụ huynh
  final String? avatar;
  final bool isActive;

  StudentModel({
    required this.id,
    required this.studentId,
    required this.fullName,
    required this.classId,
    required this.className,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.parentName,
    this.parentPhone,
    this.avatar,
    this.isActive = true,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      studentId: json['studentId'],
      fullName: json['fullName'],
      classId: json['classId'],
      className: json['className'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      address: json['address'],
      parentName: json['parentName'],
      parentPhone: json['parentPhone'],
      avatar: json['avatar'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'fullName': fullName,
      'classId': classId,
      'className': className,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'address': address,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'avatar': avatar,
      'isActive': isActive,
    };
  }

  StudentModel copyWith({
    String? id,
    String? studentId,
    String? fullName,
    String? classId,
    String? className,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? parentName,
    String? parentPhone,
    String? avatar,
    bool? isActive,
  }) {
    return StudentModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      fullName: fullName ?? this.fullName,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      parentName: parentName ?? this.parentName,
      parentPhone: parentPhone ?? this.parentPhone,
      avatar: avatar ?? this.avatar,
      isActive: isActive ?? this.isActive,
    );
  }
}