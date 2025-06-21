class ReportModel {
  final int id;
  final String title;
  final String description;
  final String severity;
  final String category;
  final String latitude;
  final String longitude;
  final String image;
  final String video;
  final String user;

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.video,
    required this.user,

  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? '',
      category: json['category'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      user: json['user'] ?? '',
    );
  }
}
