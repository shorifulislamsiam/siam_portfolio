/// Data model for an education entry.
class EducationModel {
  final String institution;
  final String degree;
  final String field;
  final String duration;
  final String? cgpa;
  final String? description;

  const EducationModel({
    required this.institution,
    required this.degree,
    required this.field,
    required this.duration,
    this.cgpa,
    this.description,
  });
}
