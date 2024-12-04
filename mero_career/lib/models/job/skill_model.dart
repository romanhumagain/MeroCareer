class Skill {
  final int? id;
  final String name;

  Skill({this.id, required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
    );
  }

  /// Converts a skill object into a JSON map
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
