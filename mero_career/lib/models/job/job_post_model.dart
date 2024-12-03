import 'package:mero_career/models/job/skill_model.dart';

import 'job_category_model.dart';

class JobPost {
  int? id;
  String jobTitle;
  int noOfVacancies;
  JobCategory jobCategory;
  String degree;
  DateTime deadline;
  String jobType;
  String jobLevel;
  List<Skill> skills;
  String jobRequirements;
  int experience;
  String salaryRange;

  JobPost({
    this.id,
    required this.jobTitle,
    required this.noOfVacancies,
    required this.jobCategory,
    required this.degree,
    required this.deadline,
    required this.jobType,
    required this.jobLevel,
    required this.skills,
    required this.jobRequirements,
    required this.experience,
    this.salaryRange = "Not Disclosed",
  });

  /// Converts a JSON map into a JobPost object
  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      id: json['id'],
      jobTitle: json['job_title'],
      noOfVacancies: json['no_of_vacancies'],
      jobCategory: JobCategory.fromJson(json['job_category']),
      degree: json['degree'],
      deadline: DateTime.parse(json['deadline']),
      jobType: json['job_type'],
      jobLevel: json['job_level'],
      skills: (json['skills'] as List)
          .map((skillJson) => Skill.fromJson(skillJson))
          .toList(),
      jobRequirements: json['job_requirements'],
      experience: json['experience'],
      salaryRange: json['salary_range'] ?? "Not Disclosed",
    );
  }

  /// Converts a JobPost object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'job_title': jobTitle,
      'no_of_vacancies': noOfVacancies,
      'job_category': jobCategory.toJson(),
      'degree': degree,
      'deadline': deadline.toIso8601String(),
      'job_type': jobType,
      'job_level': jobLevel,
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'job_requirements': jobRequirements,
      'experience': experience,
      'salary_range': salaryRange,
    };
  }
}
