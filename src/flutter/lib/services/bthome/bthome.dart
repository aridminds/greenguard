import 'dart:typed_data';

import 'package:greenguard/services/bthome/data_type.dart';
import 'package:greenguard/services/bthome/measurement.dart';
import 'package:greenguard/services/bthome/measurement_type.dart';
import 'package:greenguard/services/bthome/sensor_type.dart';

// Object id 	Property 	Data type 	Factor 	Example 	Result 	Unit
// 0x51 	acceleration 	uint16 (2 bytes) 	0.001 	518756 	22.151 	m/s²
// 0x01 	battery 	uint8 (1 byte) 	1 	0161 	97 	%
// 0x12 	co2 	uint16 (2 bytes) 	1 	12E204 	1250 	ppm
// 0x09 	count 	uint (1 bytes) 	1 	0960 	96
// 0x3D 	count 	uint (2 bytes) 	1 	3D0960 	24585
// 0x3E 	count 	uint (4 bytes) 	1 	3E2A2C0960 	1611213866
// 0x43 	current 	uint16 (2 bytes) 	0.001 	434E34 	13.39 	A
// 0x08 	dewpoint 	sint16 (2 bytes) 	0.01 	08CA06 	17.38 	°C
// 0x40 	distance (mm) 	uint16 (2 bytes) 	1 	400C00 	12 	mm
// 0x41 	distance (m) 	uint16 (2 bytes) 	0.1 	414E00 	7.8 	m
// 0x42 	duration 	uint24 (3 bytes) 	0.001 	424E3400 	13.390 	s
// 0x4D 	energy 	uint32 (4 bytes) 	0.001 	4d12138a14 	344593.170 	kWh
// 0x0A 	energy 	uint24 (3 bytes) 	0.001 	0A138A14 	1346.067 	kWh
// 0x4B 	gas 	uint24 (3 bytes) 	0.001 	4B138A14 	1346.067 	m3
// 0x4C 	gas 	uint32 (4 bytes) 	0.001 	4C41018A01 	25821.505 	m3
// 0x52 	gyroscope 	uint16 (2 bytes) 	0.001 	528756 	22.151 	°/s
// 0x03 	humidity 	uint16 (2 bytes) 	0.01 	03BF13 	50.55 	%
// 0x2E 	humidity 	uint8 (1 byte) 	1 	2E23 	35 	%
// 0x05 	illuminance 	uint24 (3 bytes) 	0.01 	05138A14 	13460.67 	lux
// 0x06 	mass (kg) 	uint16 (2 byte) 	0.01 	065E1F 	80.3 	kg
// 0x07 	mass (lb) 	uint16 (2 byte) 	0.01 	073E1D 	74.86 	lb
// 0x14 	moisture 	uint16 (2 bytes) 	0.01 	14020C 	30.74 	%
// 0x2F 	moisture 	uint8 (1 byte) 	1 	2F23 	35 	%
// 0x0D 	pm2.5 	uint16 (2 bytes) 	1 	0D120C 	3090 	ug/m3
// 0x0E 	pm10 	uint16 (2 bytes) 	1 	0E021C 	7170 	ug/m3
// 0x0B 	power 	uint24 (3 bytes) 	0.01 	0B021B00 	69.14 	W
// 0x04 	pressure 	uint24 (3 bytes) 	0.01 	04138A01 	1008.83 	hPa
// 0x54 	raw 	see below 	- 	540C48656C6C6F 20576F726C6421 	48656c6c6f20 576f726c6421
// 0x3F 	rotation 	sint16 (2 bytes) 	0.1 	3F020C 	307.4 	°
// 0x44 	speed 	uint16 (2 bytes) 	0.01 	444E34 	133.90 	m/s
// 0x45 	temperature 	sint16 (2 bytes) 	0.1 	451101 	27.3 	°C
// 0x02 	temperature 	sint16 (2 bytes) 	0.01 	02CA09 	25.06 	°C
// 0x53 	text 	see below 	- 	530C48656C6C6F 20576F726C6421 	Hello World!
// 0x50 	timestamp 	uint48 (4 bytes) 	- 	505d396164 	see below
// 0x13 	tvoc 	uint16 (2 bytes) 	1 	133301 	307 	ug/m3
// 0x0C 	voltage 	uint16 (2 bytes) 	0.001 	0C020C 	3.074 	V
// 0x4A 	voltage 	uint16 (2 bytes) 	0.1 	4A020C 	307.4 	V
// 0x4E 	volume 	uint32 (4 bytes) 	0.001 	4E87562A01 	19551.879 	L
// 0x47 	volume 	uint16 (2 bytes) 	0.1 	478756 	2215.1 	L
// 0x48 	volume 	uint16 (2 bytes) 	1 	48DC87 	34780 	mL
// 0x55 	volume storage 	uint32 (4 bytes) 	0.001 	5587562A01 	19551.879 	L
// 0x49 	volume Flow Rate 	uint16 (2 bytes) 	0.001 	49DC87 	34.780 	m3/hr
// 0x46 	UV index 	uint8 (1 byte) 	0.1 	4632 	5.0
// 0x4F 	water 	uint32 (4 bytes) 	0.001 	4F87562A01 	19551.879 	L

class BTHomeSensor {
  final List<MeasurementType> _measurementTypes = [
    MeasurementType(0x51, SensorType.acceleration, DataType.uint16, 2, 0.001),
    MeasurementType(0x01, SensorType.battery, DataType.uint8, 1, 1),
    MeasurementType(0x12, SensorType.co2, DataType.uint16, 2, 1),
    MeasurementType(0x09, SensorType.count, DataType.uint, 1, 1),
    MeasurementType(0x3D, SensorType.count, DataType.uint, 2, 1),
    MeasurementType(0x3E, SensorType.count, DataType.uint, 4, 1),
    MeasurementType(0x43, SensorType.current, DataType.uint16, 2, 0.001),
    MeasurementType(0x08, SensorType.dewpoint, DataType.sint16, 2, 0.01),
    MeasurementType(0x40, SensorType.distanceMm, DataType.uint16, 2, 1),
    MeasurementType(0x41, SensorType.distanceM, DataType.uint16, 2, 0.1),
    MeasurementType(0x42, SensorType.duration, DataType.uint24, 3, 0.001),
    MeasurementType(0x4D, SensorType.energy, DataType.uint32, 4, 0.001),
    MeasurementType(0x0A, SensorType.energy, DataType.uint24, 3, 0.001),
    MeasurementType(0x4B, SensorType.gas, DataType.uint24, 3, 0.001),
    MeasurementType(0x4C, SensorType.gas, DataType.uint32, 4, 0.001),
    MeasurementType(0x52, SensorType.gyroscope, DataType.uint16, 2, 0.001),
    MeasurementType(0x03, SensorType.humidity, DataType.uint16, 2, 0.01),
    MeasurementType(0x2E, SensorType.humidity, DataType.uint8, 1, 1),
    MeasurementType(0x05, SensorType.illuminance, DataType.uint24, 3, 0.01),
    MeasurementType(0x06, SensorType.massKg, DataType.uint16, 2, 0.01),
    MeasurementType(0x07, SensorType.massLb, DataType.uint16, 2, 0.01),
    MeasurementType(0x14, SensorType.moisture, DataType.uint16, 2, 0.01),
    MeasurementType(0x2F, SensorType.moisture, DataType.uint8, 1, 1),
    MeasurementType(0x0D, SensorType.pm2_5, DataType.uint16, 2, 1),
    MeasurementType(0x0E, SensorType.pm10, DataType.uint16, 2, 1),
    MeasurementType(0x0B, SensorType.power, DataType.uint24, 3, 0.01),
    MeasurementType(0x04, SensorType.pressure, DataType.uint24, 3, 0.01),
    MeasurementType(0x54, SensorType.raw, DataType.raw, 0, 0),
    MeasurementType(0x3F, SensorType.rotation, DataType.sint16, 2, 0.1),
    MeasurementType(0x44, SensorType.speed, DataType.uint16, 2, 0.01),
    MeasurementType(0x45, SensorType.temperature, DataType.sint16, 2, 0.1),
    MeasurementType(0x02, SensorType.temperature, DataType.sint16, 2, 0.01),
    MeasurementType(0x53, SensorType.text, DataType.text, 0, 0),
    MeasurementType(0x50, SensorType.timestamp, DataType.uint48, 4, 0),
    MeasurementType(0x13, SensorType.tvoc, DataType.uint16, 2, 1),
    MeasurementType(0x0C, SensorType.voltage, DataType.uint16, 2, 0.001),
    MeasurementType(0x4A, SensorType.voltage, DataType.uint16, 2, 0.1),
    MeasurementType(0x4E, SensorType.volume, DataType.uint32, 4, 0.001),
    MeasurementType(0x47, SensorType.volume, DataType.uint16, 2, 0.1),
    MeasurementType(0x48, SensorType.volume, DataType.uint16, 2, 1),
    MeasurementType(0x55, SensorType.volumeStorage, DataType.uint32, 4, 0.001),
    MeasurementType(0x49, SensorType.volumeFlowRate, DataType.uint16, 2, 0.001),
    MeasurementType(0x46, SensorType.uvIndex, DataType.uint8, 1, 0.1),
    MeasurementType(0x4F, SensorType.water, DataType.uint32, 4, 0.001),
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

  double _parseUnsignedInteger(List<int> dataObj, DataType type, [double factor = 1.0]) {
    var buffer = Uint8List.fromList(dataObj).buffer;
    var byteData = ByteData.view(buffer);
    int uint;
    switch (type) {
      case DataType.uint8:
        uint = byteData.getUint8(0);
        break;
      case DataType.uint16:
        uint = byteData.getUint16(0, Endian.little);
        break;
      case DataType.uint24:
        uint = byteData.getUint32(0, Endian.little) & 0xFFFFFF;
        break;
      case DataType.uint32:
        uint = byteData.getUint32(0, Endian.little);
        break;
      case DataType.uint48:
        uint = byteData.getUint64(0, Endian.little) & 0xFFFFFFFFFFFF;
        break;
      default:
        throw ArgumentError('Unsupported DataType');
    }
    var decimalPlaces = -int.parse(factor.toStringAsExponential().split('e').last);
    return double.parse((uint * factor).toStringAsFixed(decimalPlaces));
  }

  double _parseSignedInteger(List<int> dataObj, DataType type, [double factor = 1.0]) {
    var buffer = Uint8List.fromList(dataObj).buffer;
    var byteData = ByteData.view(buffer);
    int intVal;
    switch (type) {
      case DataType.sint16:
        intVal = byteData.getInt16(0, Endian.little);
        break;
      default:
        throw ArgumentError('Unsupported DataType');
    }
    var decimalPlaces = -int.parse(factor.toStringAsExponential().split('e').last);
    return double.parse((intVal * factor).toStringAsFixed(decimalPlaces));
  }

  List<Measurement> _parsePayload(List<int> payload) {
    var payloadLength = payload.length;
    var nextIndex = 0;
    var measurements = <Measurement>[];

    while (payloadLength >= nextIndex + 1) {
      var index = nextIndex;

      var objectId = payload[index];
      var measurementType = _measurementTypes.firstWhere((element) => element.objectId == objectId);

      var measurementLength = measurementType.dataLength;
      var measurementIndex = index + 1;

      nextIndex = measurementIndex + measurementLength;

      if (payloadLength < nextIndex) {
        break;
      }

      var data = payload.sublist(measurementIndex, nextIndex);

      switch (measurementType.dataType) {
        case DataType.uint:
        case DataType.uint8:
        case DataType.uint16:
        case DataType.uint24:
        case DataType.uint32:
        case DataType.uint48:
          var value = _parseUnsignedInteger(data, measurementType.dataType, measurementType.factor);
          measurements.add(Measurement(measurementType, value));
          break;
        case DataType.sint16:
          var value = _parseSignedInteger(data, measurementType.dataType, measurementType.factor);
          measurements.add(Measurement(measurementType, value));
          break;
        case DataType.raw:
        case DataType.text:
          throw Exception('raw and text data types are not supported');
      }
    }

    return measurements;
  }
}