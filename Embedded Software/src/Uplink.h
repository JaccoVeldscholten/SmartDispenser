#ifndef UPLINK_H
#define UPLINK_H

#include <HTTPClient.h>
#include <ArduinoJson.h>

class Uplink
{
private:
    WiFiClient client;
    HTTPClient http;
public:
    Uplink();
    void SendData();                

    String APIUrl;                   /* Storage for API URL */
    StaticJsonDocument<200> doc;     /* DataFrame object */

};
 
#endif