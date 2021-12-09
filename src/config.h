#ifndef _CONFIG_H 
#define _CONFIG_H



/* WiFi Settings */
//#define WIFI_SSID                       "Uitvinderz"
//#define WIFI_PASSWORD                   "u!tv1nderz"

#define WIFI_SSID                       "BAVA"
#define WIFI_PASSWORD                   "u!tv1nderz"

//#define WIFI_SSID                       "FBI Bus"
//#define WIFI_PASSWORD                   "w@chtw00rd!"

//#define WIFI_SSID                       "iPhone van Jacco"
//#define WIFI_PASSWORD                   "w@chtw00rd!"

#define DEFAULE_WIFI_MODE               1
#define WIFI_TIMER_TRESHOLD             20 /* Minimal treshold value before WiFi timout */


/* Defines the Min/Max Treshold of Stench in TVOC value */
#define TRESHOLD_PPM_MIN                3
#define TRESHOLD_PPM_MAX                5

/* Defines the Min/Max Treshold of Stench in CO2 value */
#define TRESHOLD_CO2_MIN                200
#define TRESHOLD_CO2_MAX                500

/* API URL To Send Data to */
#define API_URL                         "http://us-central1-bava-solutions.cloudfunctions.net/AddDeviceData"

/* Measurement Interval */
/* Time Device will go to sleep (in seconds) */
#define TIME_TO_SLEEP          60                 
 /* Time Device will go to sleep (in seconds) before recheck if someone left the toilet */
#define TIME_TO_SLEEP_RECHECK  60                

/* Hardware Configuration */
#define GPIO_MOTION_PIR 14            


/* Timer Sleep Configuration (Keep as it) */
#define uS_TO_S_FACTOR 1000000            // Conversion factor for micro seconds to seconds






/* SSL Certificate */
const char* root_ca= \
"-----BEGIN CERTIFICATE-----\n" \
"MIIDzTCCArWgAwIBAgIQCjeHZF5ftIwiTv0b7RQMPDANBgkqhkiG9w0BAQsFADBa \n" \
"MQswCQYDVQQGEwJJRTESMBAGA1UEChMJQmFsdGltb3JlMRMwEQYDVQQLEwpDeWJl \n" \
"clRydXN0MSIwIAYDVQQDExlCYWx0aW1vcmUgQ3liZXJUcnVzdCBSb290MB4XDTIw \n" \
"MDEyNzEyNDgwOFoXDTI0MTIzMTIzNTk1OVowSjELMAkGA1UEBhMCVVMxGTAXBgNV \n" \
"BAoTEENsb3VkZmxhcmUsIEluYy4xIDAeBgNVBAMTF0Nsb3VkZmxhcmUgSW5jIEVD \n" \
"QyBDQS0zMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEua1NZpkUC0bsH4HRKlAe \n" \
"nQMVLzQSfS2WuIg4m4Vfj7+7Te9hRsTJc9QkT+DuHM5ss1FxL2ruTAUJd9NyYqSb \n" \
"16OCAWgwggFkMB0GA1UdDgQWBBSlzjfq67B1DpRniLRF+tkkEIeWHzAfBgNVHSME \n" \
"GDAWgBTlnVkwgkdYzKz6CFQ2hns6tQRN8DAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l \n" \
"BBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMBIGA1UdEwEB/wQIMAYBAf8CAQAwNAYI \n" \
"KwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5j \n" \
"b20wOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL09t \n" \
"bmlyb290MjAyNS5jcmwwbQYDVR0gBGYwZDA3BglghkgBhv1sAQEwKjAoBggrBgEF \n" \
"BQcCARYcaHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzALBglghkgBhv1sAQIw \n" \
"CAYGZ4EMAQIBMAgGBmeBDAECAjAIBgZngQwBAgMwDQYJKoZIhvcNAQELBQADggEB \n" \
"AAUkHd0bsCrrmNaF4zlNXmtXnYJX/OvoMaJXkGUFvhZEOFp3ArnPEELG4ZKk40Un \n" \
"+ABHLGioVplTVI+tnkDB0A+21w0LOEhsUCxJkAZbZB2LzEgwLt4I4ptJIsCSDBFe \n" \
"lpKU1fwg3FZs5ZKTv3ocwDfjhUkV+ivhdDkYD7fa86JXWGBPzI6UAPxGezQxPk1H \n" \
"goE6y/SJXQ7vTQ1unBuCJN0yJV0ReFEQPaA1IwQvZW+cwdFD19Ae8zFnWSfda9J1 \n" \
"CZMRJCQUzym+5iPDuI9yP+kHyCREU3qzuWFloUwOxkgAyXVjBYdwRVKD05WdRerw \n" \
"6DEdfgkfCv4+3ao8XnTSrLE= \n" \
"-----END CERTIFICATE-----\n";

#endif