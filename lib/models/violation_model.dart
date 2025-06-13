class ViolationModel {
  final String id;
  final String studentId; // ID của học sinh
  final String studentName; // Tên học sinh
  final String classId; // ID của lớp
  final String className; // Tên lớp
  final String criteriaId; // ID của tiêu chí vi phạm
  final String criteriaName; // Tên tiêu chí vi phạm
  final String criteriaCategory; // Danh mục tiêu chí
  final int points; // Điểm trừ (số âm)
  final String? note; // Ghi chú
  final String reportedBy; // ID người báo cáo
  final String reportedByName; // Tên người báo cáo
  final String date; // Ngày vi phạm (yyyy-MM-dd)
  final int week; // Tuần
  final int month; // Tháng
  final int year; // Năm
  final bool isConfirmed; // Đã được xác nhận chưa
  final String? confirmedBy; // ID người xác nhận
  final String? confirmedByName; // Tên người xác nhận
  final String? confirmedDate; // Ngày xác nhận
  final List<String>? imageUrls; // Danh sách ảnh chụp vi phạm

  ViolationModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.classId,
    required this.className,
    required this.criteriaId,
    required this.criteriaName,
    required this.criteriaCategory,
    required this.points,
    this.note,
    required this.reportedBy,
    required this.reportedByName,
    required this.date,
    required this.week,
    required this.month,
    required this.year,
    this.isConfirmed = false,
    this.confirmedBy,
    this.confirmedByName,
    this.confirmedDate,
    this.imageUrls,
  });

  factory ViolationModel.fromJson(Map<String, dynamic> json) {
    return ViolationModel(
      id: json['id'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      classId: json['classId'],
      className: json['className'],
      criteriaId: json['criteriaId'],
      criteriaName: json['criteriaName'],
      criteriaCategory: json['criteriaCategory'],
      points: json['points'],
      note: json['note'],
      reportedBy: json['reportedBy'],
      reportedByName: json['reportedByName'],
      date: json['date'],
      week: json['week'],
      month: json['month'],
      year: json['year'],
      isConfirmed: json['isConfirmed'] ?? false,
      confirmedBy: json['confirmedBy'],
      confirmedByName: json['confirmedByName'],
      confirmedDate: json['confirmedDate'],
      imageUrls: json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'classId': classId,
      'className': className,
      'criteriaId': criteriaId,
      'criteriaName': criteriaName,
      'criteriaCategory': criteriaCategory,
      'points': points,
      'note': note,
      'reportedBy': reportedBy,
      'reportedByName': reportedByName,
      'date': date,
      'week': week,
      'month': month,
      'year': year,
      'isConfirmed': isConfirmed,
      'confirmedBy': confirmedBy,
      'confirmedByName': confirmedByName,
      'confirmedDate': confirmedDate,
      'imageUrls': imageUrls,
    };
  }

  ViolationModel copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? classId,
    String? className,
    String? criteriaId,
    String? criteriaName,
    String? criteriaCategory,
    int? points,
    String? note,
    String? reportedBy,
    String? reportedByName,
    String? date,
    int? week,
    int? month,
    int? year,
    bool? isConfirmed,
    String? confirmedBy,
    String? confirmedByName,
    String? confirmedDate,
    List<String>? imageUrls,
  }) {
    return ViolationModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      criteriaId: criteriaId ?? this.criteriaId,
      criteriaName: criteriaName ?? this.criteriaName,
      criteriaCategory: criteriaCategory ?? this.criteriaCategory,
      points: points ?? this.points,
      note: note ?? this.note,
      reportedBy: reportedBy ?? this.reportedBy,
      reportedByName: reportedByName ?? this.reportedByName,
      date: date ?? this.date,
      week: week ?? this.week,
      month: month ?? this.month,
      year: year ?? this.year,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      confirmedBy: confirmedBy ?? this.confirmedBy,
      confirmedByName: confirmedByName ?? this.confirmedByName,
      confirmedDate: confirmedDate ?? this.confirmedDate,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}