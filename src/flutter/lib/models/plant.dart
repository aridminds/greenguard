import 'dart:typed_data';

class Plant {
  final int id;
  final String name;
  final String description;
  final bool bthome;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    this.bthome = false,
  });

  Plant copyWith({
    int? id,
    String? name,
    String? description,
    Uint8List? image,
    bool? isSensor,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      bthome: isSensor ?? this.bthome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'bthome': bthome ? 1 : 0,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      bthome: map['bthome'] == 1,
    );
  }

  @override
  String toString() {
    return 'PlantModel(id: $id, name: $name, description: $description, bthome: $bthome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plant && other.id == id && other.name == name && other.description == description && other.bthome == bthome;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ bthome.hashCode;
  }
}
