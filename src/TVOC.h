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
    uint16_t fetchTVOC();
    uint16_t fetchC02();
};
 
#endif