#ifndef TVOC_H
#define TVOC_H

#include <CCS811.h>

class TVOC
{
private:
    CCS811 sensor;
public:
    TVOC();

    void initSensor();
    uint8_t fetchTVOC();
    uint8_t fetchC02();
};
 
#endif