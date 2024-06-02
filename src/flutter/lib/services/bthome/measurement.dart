import 'package:greenguard/services/bthome/measurement_type.dart';

class Measurement<T> {
  final MeasurementType measurementType;
  final T data;

  Measurement(this.measurementType, this.data);
}