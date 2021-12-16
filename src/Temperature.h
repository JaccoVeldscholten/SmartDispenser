#ifndef BME280_H
#define BME280_H

#include <stdint.h>
#include <Wire.h>
#include <BME280.h>


class Temperature
{
private:
    BME280 bme;
public:
    Temperature();

    uint8_t tempValue;
    uint8_t humValue;

    
    void initSensor();
    double fetchTemp();
    double fetchHum();
    double fetchPressure();
    double fetchAltitude();
};
 
#endif