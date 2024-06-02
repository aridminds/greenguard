import 'package:greenguard/services/bthome/sensor_type.dart';

class MeasurementType {
  int objectId;
  SensorType sensorType;
  int dataLength = 1;
  dynamic dataFormat = int;
  double factor = 1;

  MeasurementType(this.objectId, this.sensorType, this.dataLength, this.dataFormat, this.factor);
}
