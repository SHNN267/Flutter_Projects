class Advertisement {
  final int id;
  final String title;
  final String content;
  final bool isActive;
  final String imageUrl;
  final String createdAt;

  Advertisement({
    required this.id,
    required this.title,
    required this.content,
    required this.isActive,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      isActive: json['is_active'] ?? false,
      imageUrl: json['image'] ?? '', // adjust if backend sends 'image_url'
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'is_active': isActive,
      'image': imageUrl,
      'created_at': createdAt,
    };
  }
}
