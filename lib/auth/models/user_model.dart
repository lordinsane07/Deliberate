class UserModel {
  final String id;
  final String? alias;
  final bool isAnonymous;

  UserModel({
    required this.id,
    this.alias,
    this.isAnonymous = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      alias: json['alias'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alias': alias,
      'isAnonymous': isAnonymous,
    };
  }
}
