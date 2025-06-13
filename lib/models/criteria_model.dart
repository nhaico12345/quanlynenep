class CriteriaModel {
  final String id;
  final String name; // Tên tiêu chí
  final String category; // Danh mục (Chuyên cần, Đồng phục, Hành vi, Vệ sinh, Học tập)
  final String description; // Mô tả chi tiết
  final int maxPoints; // Điểm tối đa
  final int minPoints; // Điểm tối thiểu (có thể âm nếu là vi phạm)
  final bool isViolation; // Có phải là tiêu chí vi phạm không
  final bool isActive;

  CriteriaModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.maxPoints,
    required this.minPoints,
    this.isViolation = false,
    this.isActive = true,
  });

  factory CriteriaModel.fromJson(Map<String, dynamic> json) {
    return CriteriaModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      maxPoints: json['maxPoints'],
      minPoints: json['minPoints'],
      isViolation: json['isViolation'] ?? false,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'maxPoints': maxPoints,
      'minPoints': minPoints,
      'isViolation': isViolation,
      'isActive': isActive,
    };
  }

  CriteriaModel copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    int? maxPoints,
    int? minPoints,
    bool? isViolation,
    bool? isActive,
  }) {
    return CriteriaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      maxPoints: maxPoints ?? this.maxPoints,
      minPoints: minPoints ?? this.minPoints,
      isViolation: isViolation ?? this.isViolation,
      isActive: isActive ?? this.isActive,
    );
  }
}