import 'package:greenguard/services/bthome/data_type.dart';
import 'package:greenguard/services/bthome/sensor_type.dart';

class MeasurementType {
  int objectId;
  SensorType sensorType;
  DataType dataType = DataType.uint8;
  // in bytes
  int dataLength = 1;
  double factor = 1;

  MeasurementType(this.objectId, this.sensorType, this.dataType, this.dataLength , this.factor);
}
