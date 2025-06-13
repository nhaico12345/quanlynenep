class ClassModel {
  final String id;
  final String className; // Tên lớp (VD: 10A1)
  final String grade; // Khối (VD: 10, 11, 12)
  final String? homeTeacherId; // ID của giáo viên chủ nhiệm
  final String? homeTeacherName; // Tên giáo viên chủ nhiệm
  final int studentCount; // Số lượng học sinh
  final int schoolYear; // Năm học (VD: 2023)
  final bool isActive;

  ClassModel({
    required this.id,
    required this.className,
    required this.grade,
    this.homeTeacherId,
    this.homeTeacherName,
    required this.studentCount,
    required this.schoolYear,
    this.isActive = true,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      className: json['className'],
      grade: json['grade'],
      homeTeacherId: json['homeTeacherId'],
      homeTeacherName: json['homeTeacherName'],
      studentCount: json['studentCount'],
      schoolYear: json['schoolYear'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'grade': grade,
      'homeTeacherId': homeTeacherId,
      'homeTeacherName': homeTeacherName,
      'studentCount': studentCount,
      'schoolYear': schoolYear,
      'isActive': isActive,
    };
  }

  ClassModel copyWith({
    String? id,
    String? className,
    String? grade,
    String? homeTeacherId,
    String? homeTeacherName,
    int? studentCount,
    int? schoolYear,
    bool? isActive,
  }) {
    return ClassModel(
      id: id ?? this.id,
      className: className ?? this.className,
      grade: grade ?? this.grade,
      homeTeacherId: homeTeacherId ?? this.homeTeacherId,
      homeTeacherName: homeTeacherName ?? this.homeTeacherName,
      studentCount: studentCount ?? this.studentCount,
      schoolYear: schoolYear ?? this.schoolYear,
      isActive: isActive ?? this.isActive,
    );
  }
}