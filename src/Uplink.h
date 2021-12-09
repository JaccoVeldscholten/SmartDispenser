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
    void PrintAPI();        /* Debug Function */
    void SendData();        /* Send Data Struct Function */

    String APIUrl;                   /* Storage for API URL */
    StaticJsonDocument<200> doc;     /* DataFrame object */

};
 
#endif