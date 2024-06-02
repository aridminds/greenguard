#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>

#define SERVICE_UUID "38b3bfe1-abbd-4550-bc0f-2577ef6d0f0b"

BLECharacteristic soilMoistureCharacteristics("3b7a1ffe-0326-42df-8b07-ddcb03ce1337", BLECharacteristic::PROPERTY_NOTIFY | BLECharacteristic::PROPERTY_READ);
BLEDescriptor soilMoistureDescriptor(BLEUUID((uint16_t)0x2903));

bool deviceConnected = false;

class DeviceCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer *pServer) {
    deviceConnected = true;
    Serial.println("onConnect");
  };
  void onDisconnect(BLEServer *pServer) {
    deviceConnected = false;
    Serial.println("onDisconnect");
  }
};

void setupBle() {
  BLEDevice::init("plantprotector");

  BLEServer *server = BLEDevice::createServer();
  server->setCallbacks(new DeviceCallbacks());

  BLEService *service = server->createService(SERVICE_UUID);
  service->addCharacteristic(&soilMoistureCharacteristics);
  soilMoistureDescriptor.setValue("SoilMoisture");
  service->start();

  BLEAdvertising *advertising = BLEDevice::getAdvertising();
  advertising->addServiceUUID(SERVICE_UUID);
  server->getAdvertising()->start();
  Serial.println("Waiting a client connection to notify...");
}

void writeValue(std::string value) {
  soilMoistureCharacteristics.setValue(value);
  soilMoistureCharacteristics.notify();
}