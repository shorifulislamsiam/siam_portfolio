/// Data model for a certificate entry.
class CertificateModel {
  final String title;
  final String organization;
  final String date;
  final String? imageUrl;
  final String? verifyUrl;

  const CertificateModel({
    required this.title,
    required this.organization,
    required this.date,
    this.imageUrl,
    this.verifyUrl,
  });
}
