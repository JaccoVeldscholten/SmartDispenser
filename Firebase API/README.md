
## Index

[Overview API](#overview-api)

[Run Locally](#run-locally)

[Documentation](#documentation)

- ###### [AddDevice](#adddevice-1)
- ###### [AddDeviceData](#adddevicedata-1)
- ###### [AddLocation](#addlocation-1)
- ###### [GetAllBuildings](#getallbuildings-1)
- ###### [GetDeviceStatusPerBuilding](#getdevicestatusperbuilding-1)
- ###### [GetLogsOfADevice](#getlogsofadevice-1)
- ###### [GetStatsOfADevice](#getstatsofadevice-1)
- ###### [RemoveDevice](#removedevice-1)
- ###### [RemoveLocation](#removelocation-1)


[Deployment](#deployment)

[FAQ](#faq)


## Overview API

The API is hosted on Firebase functions. We choose for Firebase because we can also use Firebase Firestore as our document-based-database. Besides you pay for what you use. So if you don’t have a lot of customers you will not do a lot of requests to Firebase which means the costs for the API will also be low. As you can see in the image below there is even a free quota. So for development we don’t

With this API you can interact with the data which is generated by the smart dispensers.
You can also use our app which has the API integrated.

## Run Locally

Clone the project

```bash
  git clone git@gitlab.com:bava-solutions/bava-solutions-api.git
```

Go to the project directory

```bash
  cd bava-solutions-api
```

Install dependencies

```bash
  cd functions
  npm install
  npm install firebase-tools -g
  npm install nodemon -g
```

Start the server

```bash
  cd functions (if youre not already there)
  nodemon -e ts --exec "npm run serve"
```


## Documentation

In production environment the url for the api is "https://us-central1-bava-solutions.cloudfunctions.net/"
In development environment the url for the api is "http://localhost:5001/bava-solutions/us-central1/"


### AddDevice

POST `url/AddDevice`

| **Parameter** | **Type** | **Explanation**                                   |
| ------------- | -------- | ------------------------------------------------- |
| building      | String   | The name of the building you want to add.         |
| gender        | Number   | 0 = both genders. 1 = male. 2 = female.           |
| name          | String   | This is the name of the smartdispenser.           |
| mac           | String   | This is the macaddress of the smartdispenser.     |
| description   | String   | This is a description of the smartdispenser.      |
| location      | String   | The location where the smartdispenser is located. |

Possible return code with data
```
StatusCode 315:
    "Please send a POST request"
StatusCode 404:
    "No building found with the name of {building}"
StatusCode 400:
{
    "err": error
}
StatusCode 200:
    "Device succesfully added!"
```

### AddDeviceData

POST `url/AddDeviceData`

| **Parameter** | **Type** | **Explanation**                                                                                            |
| ------------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| tvoc\_ppm     | Number   | This is the measured air quality                                                                           |
| tvoc\_co2     | Number   | This is the meusured CO2 that’s in the air                                                                 |
| temp          | Number   | This is the temperature that the sensor of the smart dispenser measures.                                   |
| hum           | Number   | This is the humidity that is measured                                                                      |
| occupied      | Boolean  | This variable will be true if someone is using the toilet. If the toilet is not occupied it will be false. |
| mac           | String   | This is the mac-address of the smart dispenser.                                                            |
| pressure      | Number   | This is the measured pressure in the air.                                                                  |
| altitude      | Number   | This will be submitted because we want to check if the altitude has some impact on the other values.       |
| liquidLevel   | Number   | This is a percentage of the amount of liquid left in the smartdispenser.                                   |
| batteryLevel  | Number   | This is a percentage of energy still left in the battery.                                                  |

Possible return codes with data
```
StatusCode 315:
    "Please send a POST request"
StatusCode 400:
{
    "err": error
}
StatusCode 400:
{
    "Temperature too high. Log aborted"
}
StatusCode 200:
    "Sensordata successful submitted"
```


### AddLocation

POST `url/AddLocation`

| **Parameter** | **Type** | **Explanation**                                  |
| ------------- | -------- | ------------------------------------------------ |
| buildingName  | String   | This is the name of the building you want to add |
| companyName   | String   | This is the company of the building              |
| address       | String   | This is the address of the building              |

Possible return codes with data
```
StatusCode 315:
    "Please send a POST request"
StatusCode 400:
{
    "err": error
}
StatusCode 200:
    "Location successful added"
```

### GetAllBuildings

GET `url/GetAllBuildings`

Possible return code with data
```
StatusCode 400:
{
    "err": error
}
StatusCode 200:
[
    "Chef",
    "Fokke",
    "Hanz",
    "BuildingGoogle"
]

```


### GetDeviceStatusPerBuilding

in the place of `MACADDRES` you need to put the macaddress

GET `url/GetDeviceStatusPerBuilding/MACADDRES`

Possible return code with data
```
StatusCode 404:
    "No building found with the name of {BUILDING}"
StatusCode 404:
    "No devices connected to building {BUILDING}"
StatusCode 400:
{
    "err": error
}
StatusCode 200:
[
  {
    "mac": "F0:08:D1:D8:07:D4",
    "altitude": 142,
    "tvoc_ppm": 8,
    "tvoc_co2": 198,
    "liquidLevel": 100,
    "timestamp": {
      "_seconds": 1638423192,
      "_nanoseconds": 216000000
    },
    "pressure": 99682,
    "hum": 36,
    "batteryLevel": 100,
    "occupied": true,
    "temp": 19,
    "name": "real device",
    "location": "Jacco WC",
    "description": "pls dont delete",
    "gender": 0
  }
]
```


### GetLogsOfADevice

in the place of `MACADDRES` you need to put the macaddress

GET `url/GetLogsOfADevice/MACADDRES`

Possible return code with data
```
StatusCode 400:
{
    "err": error
}
StatusCode 200:
[
  {
    "tvoc_co2": 0,
    "hum": 40,
    "batteryLevel": 100,
    "occupied": true,
    "temp": 23,
    "liquidLevel": 100,
    "timestamp": {
      "_seconds": 1638397086,
      "_nanoseconds": 712000000
    },
    "altitude": 160,
    "pressure": 99477,
    "mac": "F0:08:D1:D8:07:D4",
    "tvoc_ppm": 0
  },
  {
    "tvoc_co2": 179,
    "batteryLevel": 100,
    "hum": 40,
    "mac": "F0:08:D1:D8:07:D4",
    "temp": 23,
    "timestamp": {
      "_seconds": 1638397235,
      "_nanoseconds": 972000000
    },
    "pressure": 99480,
    "altitude": 160,
    "liquidLevel": 100,
    "tvoc_ppm": 5,
    "occupied": true
  }
]
```


### GetStatsOfADevice

in the place of `MACADDRES` you need to put the macaddress

GET `url/GetStatsOfADevice/MACADDRES`

Possible return code with data
```
StatusCode 400:
{
    "err": error
}
StatusCode 200:
{
    "TotalVisitors": {
    "01/12/2021": 7,
    "02/12/2021": 58,
    "03/12/2021": 29
    },
    "AverageTemperature": {
    "01/12/2021": 22.04,
    "02/12/2021": 21.589041095890412,
    "03/12/2021": 18.8796992481203
    },
    "AverageHumidity": {
    "01/12/2021": 39.28,
    "02/12/2021": 32.10502283105023,
    "03/12/2021": 30.60902255639098
    },
    "Last100MeasuredPPM": {
    "01:42": 6,
    "01:47": 8,
    "01:52": 7,
    "01:57": 7,
    }
}
```


### RemoveDevice

POST `api/RemoveDevice`

| **Parameter** | **Type** | **Explanation**                               |
| ------------- | -------- | --------------------------------------------- |
| building      | String   | The name of the building you want to delete.  |
| mac           | String   | This is the macaddress of the smartdispenser. |

Possible return code with data
```
StatusCode 315:
    "Please send a POST request"
StatusCode 404:
    "No building found with the name of {building}"
StatusCode 400:
{
    "err": error
}
StatusCode 200:
    "Device succesfully removed!"
```

### RemoveLocation

POST `url/RemoveLocation`

| **Parameter** | **Type** | **Explanation**                             |
| ------------- | -------- | ------------------------------------------- |
| buildingName  | String   | The name of the building you want to delete |

Possible return code with data
```
StatusCode 315:
    "Please send a POST request"
StatusCode 400:
{
    "err": error
}
StatusCode 200:
    "Gebouw {buildingName} verwijderd"

```
## Deployment

To deploy this project run the following commands inside your project directory

```bash
  cd functions
  npm run deploy
```

## FAQ

#### How do I use this API?

You can call the endpoints from the production environment.
There is also an example app with implementation for the API available on our Git.

#### Is the API free to use?

Yes, however in the future there might be some new functions which will be hidden behind a paywall