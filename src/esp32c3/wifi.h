#include <Arduino.h>
#include <WiFi.h>
#include "credentials.h"
#include <NTPClient.h>
#include <WiFiUdp.h>

IPAddress local_IP(192, 168, 178, 100);
IPAddress gateway(192, 168, 178, 1);
IPAddress subnet(255, 255, 255, 0);
IPAddress dns(8, 8, 8, 8);

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP);

void connectToWifi() {
  Serial.println("Trying to connect WiFi");

  // if (!WiFi.config(local_IP, gateway, subnet, dns)) {
  //   Serial.println("STA Failed to configure");
  // }

  WiFi.begin(ssid, password);

  byte cnt = 0;

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");

    cnt++;

    if (cnt > 30) {
      ESP.restart();
    }
  }

  //timeClient.begin();

  Serial.println("");
  Serial.println("Connected");
}

void updateTimeClient(){
  timeClient.update();
}

bool isConnected() {
  return WiFi.status() == WL_CONNECTED;
}