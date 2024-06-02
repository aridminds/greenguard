#include <ArduinoJson.h>
#include <WiFiClientSecure.h>
#include <HTTPClient.h>
#include <WiFi.h>

String serverName = "https://api.seven.reedsoft.de/measurement";

WiFiClientSecure client;

void sendMesurement(int value) {
  JsonDocument jsonDocument;

  jsonDocument["probeId"] = "1eb7cd21-a299-41a8-aa3c-9c17e3106b02";
  jsonDocument["measurementType"] = 64;
  jsonDocument["value"] = String(value);

  String json;

  jsonDocument.shrinkToFit();

  serializeJson(jsonDocument, json);

  Serial.println(json);

  HTTPClient http;
  client.setInsecure();

  http.begin(client, serverName);
  http.setUserAgent("esp32c3");
  http.addHeader("Content-Type", "application/json");
  http.addHeader("accept", "*/*");

  int httpCode = http.POST(json);

  if (httpCode > 0) {
    String response = http.getString();
    Serial.println(httpCode);
    Serial.println(response);
  } else {
    Serial.print("Error on sending POST: ");
    Serial.println(http.errorToString(httpCode).c_str());

    http.end();
  }
}