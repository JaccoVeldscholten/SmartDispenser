#include "Uplink.h"
 
Uplink::Uplink(){}

/* This function retrieves the right data and sends it */
void Uplink::SendData(){
    String jsonToSend;

    /* Using Mac Adress to identify in database */
    doc["mac"] = WiFi.macAddress();

    /* Serialize JSON to processing */
    serializeJsonPretty(doc, Serial);   // Debug Purpose
    serializeJson(doc, jsonToSend);

    /* Setting correct headers */
    http.begin(client, APIUrl);
    http.addHeader("Content-Type", "application/json");

    /* POST data to Server */
    if (http.POST(jsonToSend) != 200){
        //ToDo: Fix error handling
        Serial.println("Something went wrong with the API");
    }
        
    http.end();         // Free Resources
}