class DisciplineScoreModel {
  final String id;
  final String classId; // ID của lớp
  final String className; // Tên lớp
  final String criteriaId; // ID của tiêu chí
  final String criteriaName; // Tên tiêu chí
  final String criteriaCategory; // Danh mục tiêu chí
  final int points; // Điểm đạt được
  final String? note; // Ghi chú
  final String scoredBy; // ID người chấm điểm
  final String scoredByName; // Tên người chấm điểm
  final String date; // Ngày chấm điểm (yyyy-MM-dd)
  final int week; // Tuần
  final int month; // Tháng
  final int year; // Năm
  final bool isConfirmed; // Đã được xác nhận chưa
  final String? confirmedBy; // ID người xác nhận
  final String? confirmedByName; // Tên người xác nhận
  final String? confirmedDate; // Ngày xác nhận

  DisciplineScoreModel({
    required this.id,
    required this.classId,
    required this.className,
    required this.criteriaId,
    required this.criteriaName,
    required this.criteriaCategory,
    required this.points,
    this.note,
    required this.scoredBy,
    required this.scoredByName,
    required this.date,
    required this.week,
    required this.month,
    required this.year,
    this.isConfirmed = false,
    this.confirmedBy,
    this.confirmedByName,
    this.confirmedDate,
  });

  factory DisciplineScoreModel.fromJson(Map<String, dynamic> json) {
    return DisciplineScoreModel(
      id: json['id'],
      classId: json['classId'],
      className: json['className'],
      criteriaId: json['criteriaId'],
      criteriaName: json['criteriaName'],
      criteriaCategory: json['criteriaCategory'],
      points: json['points'],
      note: json['note'],
      scoredBy: json['scoredBy'],
      scoredByName: json['scoredByName'],
      date: json['date'],
      week: json['week'],
      month: json['month'],
      year: json['year'],
      isConfirmed: json['isConfirmed'] ?? false,
      confirmedBy: json['confirmedBy'],
      confirmedByName: json['confirmedByName'],
      confirmedDate: json['confirmedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'className': className,
      'criteriaId': criteriaId,
      'criteriaName': criteriaName,
      'criteriaCategory': criteriaCategory,
      'points': points,
      'note': note,
      'scoredBy': scoredBy,
      'scoredByName': scoredByName,
      'date': date,
      'week': week,
      'month': month,
      'year': year,
      'isConfirmed': isConfirmed,
      'confirmedBy': confirmedBy,
      'confirmedByName': confirmedByName,
      'confirmedDate': confirmedDate,
    };
  }

  DisciplineScoreModel copyWith({
    String? id,
    String? classId,
    String? className,
    String? criteriaId,
    String? criteriaName,
    String? criteriaCategory,
    int? points,
    String? note,
    String? scoredBy,
    String? scoredByName,
    String? date,
    int? week,
    int? month,
    int? year,
    bool? isConfirmed,
    String? confirmedBy,
    String? confirmedByName,
    String? confirmedDate,
  }) {
    return DisciplineScoreModel(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      criteriaId: criteriaId ?? this.criteriaId,
      criteriaName: criteriaName ?? this.criteriaName,
      criteriaCategory: criteriaCategory ?? this.criteriaCategory,
      points: points ?? this.points,
      note: note ?? this.note,
      scoredBy: scoredBy ?? this.scoredBy,
      scoredByName: scoredByName ?? this.scoredByName,
      date: date ?? this.date,
      week: week ?? this.week,
      month: month ?? this.month,
      year: year ?? this.year,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      confirmedBy: confirmedBy ?? this.confirmedBy,
      confirmedByName: confirmedByName ?? this.confirmedByName,
      confirmedDate: confirmedDate ?? this.confirmedDate,
    );
  }
}