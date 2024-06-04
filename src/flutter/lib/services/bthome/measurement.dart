import 'package:greenguard/services/bthome/measurement_type.dart';

class Measurement {
  final MeasurementType measurementType;
  final double data;

  Measurement(this.measurementType, this.data);
}