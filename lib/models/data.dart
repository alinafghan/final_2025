class Data {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Data{id: $id, name: $name, description: $description, imageUrl: $imageUrl}';
  }

  Data copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
