import 'dart:typed_data';

class Plant {
  final int id;
  final String name;
  final String description;
  final Uint8List? image;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    this.image,
  });

  Plant copyWith({
    int? id,
    String? name,
    String? description,
    Uint8List? image,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
    );
  }

  @override
  String toString() {
    return 'PlantModel(id: $id, name: $name, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plant &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ image.hashCode;
  }
}
