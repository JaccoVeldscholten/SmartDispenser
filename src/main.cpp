#include <Arduino.h>
#include <WiFi.h>
#include <TVOC.h>
#include <Uplink.h>
#include <BME280.h>
#include <Temperature.h>
#include "driver/gpio.h"
#include <esp_wifi.h>

#include "config.h"


typedef enum STATE
/** Enum type for StateMachine. 
 *  A state machine is used to avoid errors. 
 *  Because a state is fixed, it is not possible to simply call in a wrong state.
 *  There are mulitple states mentioned.
*/
{
  MAIN,                   /**<  Main state */
  DIFFUSING,              /**<  Difussing state */
  PERSON_ENTERED,         /**<  Someone entered the toilet state*/
  FAILURE                 /**<  In case something went wrong */
} State;

TVOC tvoc;                                /*!< Constructor for the TVOC Sensor */
Uplink server;                            /*!< Constructor for the Uplink Server */
Temperature temp;                         /*!< Constructor for the Temperature & Humidty sensor*/

RTC_DATA_ATTR int bootCount = 0;         /*!< RCC Data Adress being used to keep this variable after deep sleep */
RTC_DATA_ATTR State state;               /*!< RCC Data Adress being used to keep this variable after deep sleep */
RTC_DATA_ATTR bool checkSum = false;     /*!< RCC Data Adress being used to keep this variable after deep sleep */



void UploadData(void);
void CheckAirQuality(void);
void SelectWakeUp(void);
void setup(void);


void UploadData(void)
{
  /**
  * 
  * This function will fetch all the sensor values and arrange them in JSON format
  * 
  * After this the files will be send to "Uplink class" to proceed uploading
  * 
  * @warning Waterlevel & batteryLevel are not implemented yet
  */
  server.doc["tvoc_ppm"] = tvoc.fetchTVOC();
  server.doc["tvoc_co2"] = tvoc.fetchC02();
  server.doc["temp"] = temp.fetchTemp();
  server.doc["hum"] = temp.fetchHum();
  server.doc["occupied"] = (state == PERSON_ENTERED) ? true : false;
  server.doc["pressure"] = temp.fetchPressure();
  server.doc["altitude"] = temp.fetchAltitude();
  server.doc["liquidLevel"] = 100;
  server.doc["batteryLevel"] = 100;
  // Mac Adress is added in function SendData  server.doc["mac"]

  server.SendData();
}


void CheckAirQuality(void){

  /**
  * 
  * This function will check if the values of the stench are high (TVOC)
  * 
  * In case the TVOC values are between setted Treshholds the state DIFFUSING is kicked in.
  * 
  * @note The tresholds are able to change in "config.h"
  */
  if ((tvoc.fetchTVOC() >= TRESHOLD_PPM_MIN) && (tvoc.fetchTVOC() <= TRESHOLD_PPM_MAX) ){
      Serial.println("It stinks");
      state = DIFFUSING;
  }
}


void SelectWakeUp(void)
{
  /**
  * When the device wakes up after sleep this function will check waht sleep mode it came from.
  * In this way its possible to set the state caused by someone that entered the toilet.
  */
  switch (esp_sleep_get_wakeup_cause())
  {
  case 2:
    Serial.println("Wakeup caused by PIR");
    state = PERSON_ENTERED;
    break;
  case 4:
    Serial.println("Wakeup caused by timer");
    break;
  default:
    Serial.println("Wakeup was not caused by something else");
    break;
  }
}

void setup()
{
  Serial.begin(DEBUG_BAUD);
  sys_delay_ms(100);                                    /* Give the Bus some time to setup */
  bootCount++;                                          /* Keep track of the boot time */
  Serial.println("Boot number: " + String(bootCount));
  Serial.println("We are coming in with state: " + String(state));
  SelectWakeUp();

  pinMode(GPIO_MOTION_PIR, INPUT);

  server.APIUrl = API_URL; // Parse config

  /* Init the sensors without spamming the I2C bus */
  /* The delay also helps to give the TVOC Sensor time to measure */
  tvoc.initSensor();
  sys_delay_ms(250);
  temp.initSensor();
  sys_delay_ms(250);

  Serial.println("Setup wifi Begin\n");
  WiFi.disconnect();
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  
  uint8_t wifiTimout = 0;
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print('.');
    delay(1000);
    /* In case the WiFi is still not connected the MCU will restart */
    if(wifiTimout++ > WIFI_TIMER_TRESHOLD){
      ESP.restart();
    }
  }
  Serial.println();
  Serial.println("Connected!");

  Serial.println(digitalRead(GPIO_MOTION_PIR));
  if ((!digitalRead(GPIO_MOTION_PIR)) && (state == PERSON_ENTERED) && (checkSum))
  {
    /**
     * **Person Left Toilet State**
     * 
     * This state is activated when the current Timer (2 min, configureable in "config.h") is triggerd.
     * Another condition is that the value of the motion detector must be 0. (No Motion) 
     * 
     * First, the data is uploaded to the server.
     * After that, a measurement is started to see if there is any stench in the toilet.
     * Then all interrupts are activated again.
     * 
     * Finally, the state of the device is set back to main.
     * 
     * @note variable checkSum is being used to prevent to join the state again if the person is not left yet.
     */
    checkSum = false;
    state = MAIN;
    UploadData();
    esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP * uS_TO_S_FACTOR );
    esp_sleep_enable_ext0_wakeup(GPIO_NUM_14, 1);
    Serial.println("\nPERSON LEFT TOILET (Sleep 10 min now)");
  }

  if(digitalRead(GPIO_MOTION_PIR) && (state == PERSON_ENTERED) && (checkSum)){
    /**
     * **Person Still on Toilet State**
     * 
     * This state is activated when the current Timer (2 min, configureable in "config.h") is triggerd.
     * Another condition is that the value of the motion detector must be 1. (Still Motion) 
     * 
     * This state is very clear. Just bring the device back in sleep mode. And check in 2 min again :)
     * 
     * @note variable checkSum is being used to prevent to join the state again if the person is not left yet.
     */
    Serial.println("\nPERSON STILL ON TOILET (Sleep 2 min now)");
    esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP_RECHECK * uS_TO_S_FACTOR );
  }

  if ((state == PERSON_ENTERED) && (!checkSum))
  {
    /**
     * **Person Entered Toilet State**
     * 
     * This state is activated when the Motion Detector (PIR) is triggerd.
     * After this the PIR Interrupt is being disabled.
     * 
     * The global interrupt timer is set to 2 min (Changable in "config.h") 
     * This timer will check every 2 min if the person left the toilet.
     * 
     * Finally, the data will be uploaded to the server. This will indicate that the toilet is occupied.
     * 
     * @note variable checkSum is being used to prevent to join the state again if the person is not left yet.
     */
    checkSum = true;
    esp_sleep_disable_wakeup_source(ESP_SLEEP_WAKEUP_EXT1);
    esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP_RECHECK * uS_TO_S_FACTOR );
    UploadData();
    CheckAirQuality();
    Serial.println("\nPERSON ENTERED TOILET (Sleep 2 min now)");
  }

  if (state == MAIN)
  {
    /**
     * **Main Measurement State**
     * 
     * This state is triggered by a global timer that goes off every 10 minutes.
     * In this state, all interrupts are re-enabled just to be safe.
     * 
     * After this, a measurement is started to measure any stench. Then the data will be uploaded.
     * 
     */
    esp_sleep_enable_ext0_wakeup(GPIO_NUM_14, 1);
    esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP * uS_TO_S_FACTOR);
    UploadData();
    Serial.println("\nIM IN THE MAIN STATE (Sleep 10 min now)");
  }
    
  esp_deep_sleep_start();   /* Every State Entry will result in sleep */
}

void loop(){}   /* The Loop is not being used */