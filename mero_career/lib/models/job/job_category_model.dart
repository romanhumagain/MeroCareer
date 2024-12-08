class JobCategory {
  final int id;
  final String category;
  final String image;

  JobCategory({
    required this.id,
    required this.category,
    this.image = "",
  });

  /// Converts a JSON map into a JobCategory object
  factory JobCategory.fromJson(Map<String, dynamic> json) {
    return JobCategory(
      id: json['id'],
      category: json['category'],
      image: json['image'] ?? "",
    );
  }

  /// Converts a JobCategory object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'image': image,
    };
  }
}
