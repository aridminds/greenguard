import 'package:greenguard/models/sensor_data.dart';
import 'package:greenguard/models/watering_need.dart';

class Plant {
  final int id;
  final String name;
  final String description;
  final String? remoteId;
  final int wateringInterval;
  final DateTime? lastWatered;
  final WateringNeed wateringNeed;
  final SensorData? latestSensorData;

  bool get isBluetooth => remoteId != null;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    this.remoteId,
    this.wateringInterval = 7,
    this.lastWatered,
    this.wateringNeed = WateringNeed.low,
    this.latestSensorData,
  });

  Plant copyWith({
    int? id,
    String? name,
    String? description,
    String? remoteId,
    int? wateringInterval,
    WateringNeed? wateringNeed,
    SensorData? latestSensorData,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      remoteId: remoteId ?? this.remoteId,
      wateringInterval: wateringInterval ?? this.wateringInterval,
      wateringNeed: wateringNeed ?? this.wateringNeed,
      latestSensorData: latestSensorData ?? this.latestSensorData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'remote_id': remoteId,
      'watering_interval': wateringInterval,
      'watering_need': wateringNeed.index,
      'latest_sensor_data': latestSensorData?.toMap(),
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      remoteId: map['remote_id'],
      wateringInterval: map['watering_interval'],
      wateringNeed: WateringNeed.values[map['watering_need']],
      latestSensorData: map['latest_sensor_data'] != null ? SensorData.fromMap(map['latest_sensor_data']) : null,
    );
  }

  @override
  String toString() {
    return 'PlantModel(id: $id, name: $name, description: $description, remoteId: $remoteId), wateringInterval: $wateringInterval, wateringNeed: $wateringNeed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plant &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.remoteId == remoteId &&
        other.wateringInterval == wateringInterval &&
        other.wateringNeed == wateringNeed &&
        other.latestSensorData == latestSensorData;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ remoteId.hashCode ^ wateringInterval.hashCode ^ wateringNeed.hashCode ^ latestSensorData.hashCode;
  }
}
