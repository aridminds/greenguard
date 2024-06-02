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

enum SensorType {
  acceleration,
  battery,
  co2,
  count1,
  count2,
  count4,
  current,
  dewpoint,
  distanceMm,
  distanceM,
  duration,
  energy4Byte,
  energy3Byte,
  gas3Byte,
  gas4Byte,
  gyroscope,
  humidity2Byte,
  humidity1Byte,
  illuminance,
  massKg,
  massLb,
  moisture2Byte,
  moisture1Byte,
  pm2_5,
  pm10,
  power,
  pressure,
  raw,
  rotation,
  speed,
  temperature1Byte,
  temperature2Byte,
  text,
  timestamp,
  tvoc,
  voltage1Byte,
  voltage2Byte,
  volume,
  volume2Byte,
  volume3Byte,
  volumeStorage,
  volumeFlowRate,
  uvIndex,
  water,
}
