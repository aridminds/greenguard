import 'package:greenguard/services/bthome/measurement.dart';
import 'package:greenguard/services/bthome/measurement_type.dart';
import 'package:greenguard/services/bthome/sensor_type.dart';

class BTHomeSensor {
  final List<MeasurementType> _measurementTypes = [
    MeasurementType(0x51, SensorType.acceleration, 2, int, 0.001),
    MeasurementType(0x01, SensorType.battery, 1, int, 1),
    MeasurementType(0x12, SensorType.co2, 2, int, 1),
    MeasurementType(0x09, SensorType.count1, 1, int, 1),
    MeasurementType(0x3D, SensorType.count2, 2, int, 1),
    MeasurementType(0x3E, SensorType.count4, 4, int, 1),
    MeasurementType(0x43, SensorType.current, 2, int, 0.001),
    MeasurementType(0x08, SensorType.dewpoint, 2, int, 0.01),
    MeasurementType(0x40, SensorType.distanceMm, 2, int, 1),
    MeasurementType(0x41, SensorType.distanceM, 2, int, 0.1),
    MeasurementType(0x42, SensorType.duration, 3, int, 0.001),
    MeasurementType(0x4D, SensorType.energy4Byte, 4, int, 0.001),
    MeasurementType(0x0A, SensorType.energy3Byte, 3, int, 0.001),
    MeasurementType(0x4B, SensorType.gas3Byte, 3, int, 0.001),
    MeasurementType(0x4C, SensorType.gas4Byte, 4, int, 0.001),
    MeasurementType(0x52, SensorType.gyroscope, 2, int, 0.001),
    MeasurementType(0x03, SensorType.humidity2Byte, 2, int, 0.01),
    MeasurementType(0x2E, SensorType.humidity1Byte, 1, int, 1),
    MeasurementType(0x05, SensorType.illuminance, 3, int, 0.01),
    MeasurementType(0x06, SensorType.massKg, 2, int, 0.01),
    MeasurementType(0x07, SensorType.massLb, 2, int, 0.01),
    MeasurementType(0x14, SensorType.moisture2Byte, 2, int, 0.01),
    MeasurementType(0x2F, SensorType.moisture1Byte, 1, int, 1),
    MeasurementType(0x0D, SensorType.pm2_5, 2, int, 1),
    MeasurementType(0x0E, SensorType.pm10, 2, int, 1),
    MeasurementType(0x0B, SensorType.power, 3, int, 0.01),
    MeasurementType(0x04, SensorType.pressure, 3, int, 0.01),
    MeasurementType(0x54, SensorType.raw, 0, int, 0),
    MeasurementType(0x3F, SensorType.rotation, 2, int, 0.1),
    MeasurementType(0x44, SensorType.speed, 2, int, 0.01),
    MeasurementType(0x45, SensorType.temperature2Byte, 2, int, 0.1),
    MeasurementType(0x02, SensorType.temperature1Byte, 2, int, 0.01),
    MeasurementType(0x53, SensorType.text, 0, String, 0),
    MeasurementType(0x50, SensorType.timestamp, 4, DateTime, 0),
    MeasurementType(0x13, SensorType.tvoc, 2, int, 1),
    MeasurementType(0x0C, SensorType.voltage1Byte, 2, int, 0.001),
    MeasurementType(0x4A, SensorType.voltage2Byte, 2, int, 0.1),
    MeasurementType(0x4E, SensorType.volume, 4, int, 0.001),
    MeasurementType(0x47, SensorType.volume2Byte, 2, int, 0.1),
    MeasurementType(0x48, SensorType.volume3Byte, 2, int, 1),
    MeasurementType(0x55, SensorType.volumeStorage, 4, int, 0.001),
    MeasurementType(0x49, SensorType.volumeFlowRate, 2, int, 0.001),
    MeasurementType(0x46, SensorType.uvIndex, 1, int, 0.1),
    MeasurementType(0x4F, SensorType.water, 4, int, 0.001),
  ];

  List<Measurement> parseBTHomeV2(List<int> data) {
    var advertisingData = data[0];

    var encryption = advertisingData & (1 << 0);
    var macAddressIncluded = advertisingData & (1 << 1);

    if (encryption != 0) {
      throw Exception('encryption not supported');
    }

    if (macAddressIncluded != 0) {
      data = data.sublist(7);
    } else {
      data = data.sublist(1);
    }

    return _parsePayload(data);
  }

  double _parseInt(List<int> data, {double factor = 1.0}) {
    return (data[1] << 8) + data[0] * factor;
  }

  double _parseDouble(List<int> data, {double factor = 1.0}) {
    switch (data.length) {
      case 2:
        return (data[1] << 8) + data[0] * factor;
      case 4:
        return (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0] * factor;
      case 8:
        return (data[7] << 56) + (data[6] << 48) + (data[5] << 40) + (data[4] << 32) + (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0] * factor;
      default:
        throw Exception('only 2, 4 or 8 byte long floats are supported in BTHome BLE');
    }
  }

  String _parseString(List<int> data) {
    return data.map((byte) => String.fromCharCode(byte)).join('');
  }

  String _parseHex(List<int> data) {
    return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  }

  DateTime _parseTimestamp(List<int> data) {
    var seconds = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
    return DateTime.utc(1970, 1, 1).add(Duration(seconds: seconds));
  }

  List<Measurement> _parsePayload(List<int> payload) {
    var payloadLength = payload.length;
    var nextIndex = 0;
    var measurements = <Measurement>[];

    while (payloadLength >= nextIndex + 1) {
      var index = nextIndex;

      var objectId = payload[index];
      var measurementType = _measurementTypes.firstWhere((element) => element.objectId == objectId);

      var dataLength = measurementType.dataLength;
      var objectIdIndex = index + 1;

      index = objectIdIndex + dataLength;

      if (payloadLength < nextIndex) {
        break;
      }

      var data = payload.sublist(objectIdIndex, nextIndex);

      switch (measurementType.dataFormat) {
        case const (int):
          var value = _parseInt(data, factor: measurementType.factor);
          measurements.add(Measurement<double>(measurementType, value));
          break;
        case const (double):
          var value = _parseDouble(data, factor: measurementType.factor);
          measurements.add(Measurement<double>(measurementType, value));
          break;
        case const (String):
          var value = _parseString(data);
          measurements.add(Measurement<String>(measurementType, value));
          break;
        case const (DateTime):
          var value = _parseTimestamp(data);
          measurements.add(Measurement<DateTime>(measurementType, value));
          break;
      }
    }

    return measurements;
  }
}
