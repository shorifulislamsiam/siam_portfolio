/// Data model for a client testimonial.
class TestimonialModel {
  final String name;
  final String role;
  final String company;
  final String comment;
  final double rating; // 1.0 – 5.0
  final String? avatarUrl;

  const TestimonialModel({
    required this.name,
    required this.role,
    required this.company,
    required this.comment,
    required this.rating,
    this.avatarUrl,
  });
}
