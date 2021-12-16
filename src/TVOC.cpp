#include "TVOC.h"
 

TVOC::TVOC(){}

/**
* @brief Set measurement cycle ( Brief from Lib )
* @param cycle:in typedef enum{
*                  eClosed,      //Idle (Measurements are disabled in this mode)
*                  eCycle_1s,    //Constant power mode, IAQ measurement every second
*                  eCycle_10s,   //Pulse heating mode IAQ measurement every 10 seconds
*                  eCycle_60s,   //Low power pulse heating mode IAQ measurement every 60 seconds
*                  eCycle_250ms  //Constant power mode, sensor measurement every 250ms
*                  }eCycle_t;
*/

void TVOC::initSensor(){
    //Serial.println("Init TVOC Sensor");

    while(sensor.begin() != 0){
        Serial.println("ERR 1: Failed to setup connection with TVOC");
        delay(1000);
        //exit(-1);       /* Core dump */
    }
    sensor.setMeasCycle(sensor.eCycle_250ms);
}

uint16_t TVOC::fetchTVOC(){
    return sensor.getTVOCPPB();
}

uint16_t TVOC::fetchC02(){
    return sensor.getCO2PPM();
}
