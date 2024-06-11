class SensorData {
  final int id;
  final int plantId;
  final num? temperature;
  final num? humidity;
  final num? soilMoisture;
  final num? lightIntensity;
  final DateTime createdAt;

  SensorData({
    required this.id,
    required this.plantId,
    this.temperature,
    this.humidity,
    this.soilMoisture,
    this.lightIntensity,
    required this.createdAt,
  });

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      id: map['id'],
      plantId: map['plant_id'],
      temperature: map['temperature'],
      humidity: map['humidity'],
      soilMoisture: map['soil_moisture'],
      lightIntensity: map['light_intensity'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plant_id': plantId,
      'temperature': temperature,
      'humidity': humidity,
      'soil_moisture': soilMoisture,
      'light_intensity': lightIntensity,
      'created_at': createdAt.toIso8601String(),
    };
  }

  SensorData copyWith({
    int? id,
    int? plantId,
    num? temperature,
    num? humidity,
    num? soilMoisture,
    num? lightIntensity,
    DateTime? createdAt,
  }) {
    return SensorData(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      soilMoisture: soilMoisture ?? this.soilMoisture,
      lightIntensity: lightIntensity ?? this.lightIntensity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'SensorData{id: $id, plantId: $plantId, temperature: $temperature, humidity: $humidity, soilMoisture: $soilMoisture, lightIntensity: $lightIntensity, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SensorData &&
        other.id == id &&
        other.plantId == plantId &&
        other.temperature == temperature &&
        other.humidity == humidity &&
        other.soilMoisture == soilMoisture &&
        other.lightIntensity == lightIntensity &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ plantId.hashCode ^ temperature.hashCode ^ humidity.hashCode ^ soilMoisture.hashCode ^ lightIntensity.hashCode ^ createdAt.hashCode;
  }
}
