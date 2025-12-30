class TopicModel {
  final String id;
  final String title;
  final String description;

  TopicModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['_id'] ?? '', // Mongoose uses _id
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
