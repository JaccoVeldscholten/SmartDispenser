<div align="center">
  <a href="https://github.com/jaccoveldscholten/smartdispenser"><img src="https://github.com/JaccoVeldscholten/SmartDispenser/blob/main/docs/Logo_Medium.png" width="656" height="175"></a>
</div>

[![PlatformIO Build](https://github.com/JaccoVeldscholten/SmartDispenser/actions/workflows/build_embedded.yml/badge.svg)](https://github.com/JaccoVeldscholten/SmartDispenser/actions/workflows/build_embedded.yml)
![Build with PlatformIO](https://img.shields.io/badge/build%20with-PlatformIO-orange?logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB3aWR0aD0iMjUwMCIgaGVpZ2h0PSIyNTAwIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCI+PHBhdGggZD0iTTEyOCAwQzkzLjgxIDAgNjEuNjY2IDEzLjMxNCAzNy40OSAzNy40OSAxMy4zMTQgNjEuNjY2IDAgOTMuODEgMCAxMjhjMCAzNC4xOSAxMy4zMTQgNjYuMzM0IDM3LjQ5IDkwLjUxQzYxLjY2NiAyNDIuNjg2IDkzLjgxIDI1NiAxMjggMjU2YzM0LjE5IDAgNjYuMzM0LTEzLjMxNCA5MC41MS0zNy40OUMyNDIuNjg2IDE5NC4zMzQgMjU2IDE2Mi4xOSAyNTYgMTI4YzAtMzQuMTktMTMuMzE0LTY2LjMzNC0zNy40OS05MC41MUMxOTQuMzM0IDEzLjMxNCAxNjIuMTkgMCAxMjggMCIgZmlsbD0iI0ZGN0YwMCIvPjxwYXRoIGQ9Ik0yNDkuMzg2IDEyOGMwIDY3LjA0LTU0LjM0NyAxMjEuMzg2LTEyMS4zODYgMTIxLjM4NkM2MC45NiAyNDkuMzg2IDYuNjEzIDE5NS4wNCA2LjYxMyAxMjggNi42MTMgNjAuOTYgNjAuOTYgNi42MTQgMTI4IDYuNjE0YzY3LjA0IDAgMTIxLjM4NiA1NC4zNDYgMTIxLjM4NiAxMjEuMzg2IiBmaWxsPSIjRkZGIi8+PHBhdGggZD0iTTE2MC44NjkgNzQuMDYybDUuMTQ1LTE4LjUzN2M1LjI2NC0uNDcgOS4zOTItNC44ODYgOS4zOTItMTAuMjczIDAtNS43LTQuNjItMTAuMzItMTAuMzItMTAuMzJzLTEwLjMyIDQuNjItMTAuMzIgMTAuMzJjMCAzLjc1NSAyLjAxMyA3LjAzIDUuMDEgOC44MzdsLTUuMDUgMTguMTk1Yy0xNC40MzctMy42Ny0yNi42MjUtMy4zOS0yNi42MjUtMy4zOWwtMi4yNTggMS4wMXYxNDAuODcybDIuMjU4Ljc1M2MxMy42MTQgMCA3My4xNzctNDEuMTMzIDczLjMyMy04NS4yNyAwLTMxLjYyNC0yMS4wMjMtNDUuODI1LTQwLjU1NS01Mi4xOTd6TTE0Ni41MyAxNjQuOGMtMTEuNjE3LTE4LjU1Ny02LjcwNi02MS43NTEgMjMuNjQzLTY3LjkyNSA4LjMyLTEuMzMzIDE4LjUwOSA0LjEzNCAyMS41MSAxNi4yNzkgNy41ODIgMjUuNzY2LTM3LjAxNSA2MS44NDUtNDUuMTUzIDUxLjY0NnptMTguMjE2LTM5Ljc1MmE5LjM5OSA5LjM5OSAwIDAgMC05LjM5OSA5LjM5OSA5LjM5OSA5LjM5OSAwIDAgMCA5LjQgOS4zOTkgOS4zOTkgOS4zOTkgMCAwIDAgOS4zOTgtOS40IDkuMzk5IDkuMzk5IDAgMCAwLTkuMzk5LTkuMzk4em0yLjgxIDguNjcyYTIuMzc0IDIuMzc0IDAgMSAxIDAtNC43NDkgMi4zNzQgMi4zNzQgMCAwIDEgMCA0Ljc0OXoiIGZpbGw9IiNFNTcyMDAiLz48cGF0aCBkPSJNMTAxLjM3MSA3Mi43MDlsLTUuMDIzLTE4LjkwMWMyLjg3NC0xLjgzMiA0Ljc4Ni01LjA0IDQuNzg2LTguNzAxIDAtNS43LTQuNjItMTAuMzItMTAuMzItMTAuMzItNS42OTkgMC0xMC4zMTkgNC42Mi0xMC4zMTkgMTAuMzIgMCA1LjY4MiA0LjU5MiAxMC4yODkgMTAuMjY3IDEwLjMxN0w5NS44IDc0LjM3OGMtMTkuNjA5IDYuNTEtNDAuODg1IDIwLjc0Mi00MC44ODUgNTEuODguNDM2IDQ1LjAxIDU5LjU3MiA4NS4yNjcgNzMuMTg2IDg1LjI2N1Y2OC44OTJzLTEyLjI1Mi0uMDYyLTI2LjcyOSAzLjgxN3ptMTAuMzk1IDkyLjA5Yy04LjEzOCAxMC4yLTUyLjczNS0yNS44OC00NS4xNTQtNTEuNjQ1IDMuMDAyLTEyLjE0NSAxMy4xOS0xNy42MTIgMjEuNTExLTE2LjI4IDMwLjM1IDYuMTc1IDM1LjI2IDQ5LjM2OSAyMy42NDMgNjcuOTI2em0tMTguODItMzkuNDZhOS4zOTkgOS4zOTkgMCAwIDAtOS4zOTkgOS4zOTggOS4zOTkgOS4zOTkgMCAwIDAgOS40IDkuNCA5LjM5OSA5LjM5OSAwIDAgMCA5LjM5OC05LjQgOS4zOTkgOS4zOTkgMCAwIDAtOS4zOTktOS4zOTl6bS0yLjgxIDguNjcxYTIuMzc0IDIuMzc0IDAgMSAxIDAtNC43NDggMi4zNzQgMi4zNzQgMCAwIDEgMCA0Ljc0OHoiIGZpbGw9IiNGRjdGMDAiLz48L3N2Zz4=)


# BAVA SmartDispenser 

Smart Dispenser is a device that has been developed to measure the odor in a toilet. If the smell of the toilet is of poor quality, a diffuser will be activated to dispel or mask the bad smell.

Measuring stench is done by a TVOC sensor. Furthermore, information is collected such as the temperature, moisture and how much the toilet is used.

## Installation

#### Windows (Tested on Windows 11)
* [Visual Code](https://code.visualstudio.com/) as IDE 
* [PlatformIO for code](https://platformio.org/install/ide?install=vscode) as extension for building on ESP32
* [SolidWorks](https://www.solidworks.com/) for editing the housing

After installing these tools the project can be pulled from GitHub and opened in VSCode and compiled & flashed with PlatformIO

## Usage / compiling
Please refer to [instructions](https://docs.platformio.org/en/latest/core/quickstart.html) of PlatformIO

For adjusting standard data see the chapter configuration.


## Configuration & Enviroment Variables
Many settings can be adjusted via the file config.h. Here are the WiFi settings and more relevant values.

It is also possible to set the threshold here when the sensor should be activated. The average value in a toilet is indicated in the table below. Certain values may differ per toilet. These are therefore adjustable in the configuration file.

| Measurement Value | No Lingering smell | Middle Lingering smell  | No Lingering smell | 
| :---:   | :-: | :-: | :-: |
| TVOC PPM | 0 | 10 | > 10
| TVOC CO2 | 150 | 250 | > 250

More information and access to sample data can be seen in the Google Colab.

***Config.h***
````
/* WiFi Settings */
#define WIFI_SSID                       "TestSSID"
#define WIFI_PASSWORD                   "TestPassword!"

/* Defines the Min/Max Treshold of Stench in TVOC value */
#define TRESHOLD_PPM_MIN                3
#define TRESHOLD_PPM_MAX                5

/* Defines the Min/Max Treshold of Stench in CO2 value */
#define TRESHOLD_CO2_MIN                200
#define TRESHOLD_CO2_MAX                500

/* Measurement Interval */
#define TIME_TO_SLEEP          60     /* Time Device will go to sleep (in seconds) */            
#define TIME_TO_SLEEP_RECHECK  60     /* Time Device will go to sleep (in seconds) before recheck if someone left the toilet */
````

## Circuit Board
In order to combine the product into one product, it was decided to develop a printed circuit board containing the required sensors on board. Also, the microcontroller is soldered to the printed circuit board. More documentation about this object can be found at ....

## 3D Model & Assembly
The entire product is drawn in SolidWorks. The drawing files are included in this GitHub. A simple but handy model was taken into account because the model had to be printed with a 3D printer.

## Testing
The product has been extensively tested by data analyzes and used traceability matrixses to test the product. The results are included in this repo.

## Documentation in depth
Use the DoxyGen Folder for documentation.
For Writing Documentation use the following link: 


## License
MIT
