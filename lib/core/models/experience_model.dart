/// Data model for a work experience entry.
class ExperienceModel {
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> technologies;
  final bool isCurrent;

  const ExperienceModel({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.technologies,
    this.isCurrent = false,
  });
}
