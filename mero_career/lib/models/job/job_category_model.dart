class JobCategory {
  final int? id;
  final String name;
  final String image;

  JobCategory({
    this.id,
    required this.name,
    this.image = "",
  });

  /// Converts a JSON map into a JobCategory object
  factory JobCategory.fromJson(Map<String, dynamic> json) {
    return JobCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? "",
    );
  }

  /// Converts a JobCategory object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
