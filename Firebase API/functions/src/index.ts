import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import axios from "axios";

admin.initializeApp();

type DeviceData = {
  tvoc_ppm: number,
  tvoc_co2: number,
  temp: number,
  hum: number,
  occupied: Boolean,
  pressure: number,
  altitude: number,
  liquidLevel: number,
  batteryLevel: number,
  mac: String,
  timestamp: Date
};

//endpoint maken voor authenticatie. returnt token. dat token moet je dan gebruiken voor iedere auth


//POST http://localhost:5001/bava-solutions/us-central1/AddDeviceData
//BODY: tvoc_ppm, tvoc_co2, temp, hum, occupied, pressure, altitude, liquidLevel, batteryLevel, mac
export const AddDeviceData = functions.https.onRequest(
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "deviceLogs";

    // Check for POST request
    if (req.method !== "POST") {
        res.status(315).send("Please send a POST request");
        return;
    };

    if (req.body.temp > 40) {
      res.status(400).send("Temperature too high. Log aborted");
      return;
    };

    if (req.body.temp == 0) {
      res.status(400).send("Temperature too low. Log aborted");
      return;
    };

    if (req.body.hum == 0) {
      res.status(400).send("Humidity too low. Log aborted");
      return;
    };

    if (req.body.tvoc_co2 == 0) {
      res.status(400).send("CO2 too low. Log aborted");
      return;
    };


    const date = new Date();
    var month = `0${date.getMonth()+1}`.slice(-2);
    var dateday = `0${date.getDate()}`.slice(-2);
    var hour = `0${date.getHours()}`.slice(-2);
    var minutes = `0${date.getMinutes()}`.slice(-2);
    var seconds = `0${date.getSeconds()}`.slice(-2);
    var milliseconds = `0${date.getMilliseconds()}`.slice(-3);
    var datetimestring = `${date.getFullYear()}${month}${dateday}${hour}${minutes}${seconds}${milliseconds}`;

    var DeviceData:Required<DeviceData> = req.body;
    DeviceData.timestamp = new Date(Date.now());

    firestore.collection(collectionName).doc(datetimestring).set(DeviceData)//submit the log to firebase with datetimestring as key
      .then(() => {
          console.log("DeviceData succesfull submitted");
          res.send("DeviceData succesfull submitted");
      })
      .catch((error) => {
        console.log(`DeviceData error: ${error}`);
        res.status(400).send({err: error.message});
      });
  }
);

//POST http://localhost:5001/bava-solutions/us-central1/AddLocation
//BODY: buildingName, companyName, address
export const AddLocation = functions.https.onRequest(//TODO: only admin of own company can add a location
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "buildings";
    // Check for POST request
    if (req.method !== "POST") {
      res.status(315).send("Please send a POST request");
      return;
    };
    var data = {
      "company": req.body.companyName,
      "address": req.body.address
    };
    firestore.collection(collectionName).doc(req.body.buildingName).set(data)//add location with buildingname as key
      .then(() => {
          console.log("Location succesfull added");
          res.send("Location succesfull added");
      })
      .catch((error) => {
        console.log(`Location adding error: ${error}`);
        res.status(400).send({err: error.message});
      });
  }
);

//POST http://localhost:5001/bava-solutions/us-central1/RemoveLocation
//BODY: buildingName
export const RemoveLocation = functions.https.onRequest(//TODO: only admin of own company can remove a building
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "buildings";
    // Check for POST request
    if (req.method !== "POST") {
      res.status(315).send("Please send a POST request");
      return;
    };
    
    await firestore.collection(collectionName).doc(req.body.buildingName).delete()
      .then((response) => {
        res.send(`Gebouw ${req.body.buildingName} verwijderd`)
      })
      .catch((error) => {
        console.log(error);        
        res.status(400).send({err: error.message});
      });
  }
);

//Get http://localhost:5001/bava-solutions/us-central1/GetAllDeviceData
export const GetAllDeviceData = functions.https.onRequest(// Testing only
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "deviceLogs";

    await firestore.collection(collectionName).get()
      .then((allDocs) => {
        const allDocsData: any[] = [];
        allDocs.docs.forEach((doc) => {
          allDocsData.push(doc.data());
        });
        res.send(allDocsData);
      })
      .catch((error) => {
        console.log(error);        
        res.status(400).send({err: error.message});
      })
  }
);

//Get http://localhost:5001/bava-solutions/us-central1/GetAllBuildings
export const GetAllBuildings = functions.https.onRequest(
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "buildings";

    await firestore.collection(collectionName).get()
      .then((allDocs) => {
        const allDocsData: any[] = [];
        allDocs.docs.forEach((doc) => {
          allDocsData.push(doc.id);
        });
        res.send(allDocsData);
      })
      .catch((error) => {
        console.log(error);        
        res.status(400).send({err: error.message});
      })
  }
);

//localhost:5001/bava-solutions/us-central1/GetAllLatestDeviceData
export const GetAllLatestDeviceData = functions.https.onRequest(
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "deviceLogs";

    await firestore.collection(collectionName).get()
      .then(async (allDocs) => {
        const allDocsData: any[] = [];
        allDocs.docs.forEach((doc) => {
          allDocsData.push(doc.data());//push the data for each document so we get all the data of every log
        });

        var latestLogsPerMac = await getLatestLogPerMac(allDocsData);//here we filter only the latest data

        res.send(latestLogsPerMac);
      })
      .catch((error) => {
        console.log(error);
        res.status(400).send({err: error.message});
      })
  }
);

//localhost:5001/bava-solutions/us-central1/GetLogsOfADevice/VARIABLEMacHere
export const GetLogsOfADevice = functions.https.onRequest(
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "deviceLogs";
    const parameter = req.params[0];

    await firestore.collection(collectionName).get()
      .then(async (allDocs) => {
        const allDocsData: any[] = [];
        allDocs.docs.forEach((doc) => {
          allDocsData.push(doc.data());//first get all the logs
        });
        var groupedLogs = groupBy(allDocsData, "mac");
        var mac = parameter.slice(1, parameter.length);
        var logsOfADevice = groupedLogs[mac];//here we filter for only specific macadresses
        res.send(logsOfADevice);
      })
      .catch((error) => {
        console.log(error);
        res.status(400).send({err: error.message});
      })
  }
);

//localhost:5001/bava-solutions/us-central1/GetDeviceStatusPerBuilding/VARIABLEBuildingHere
export const GetDeviceStatusPerBuilding = functions.https.onRequest(
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "buildings";
    const parameter = req.params[0];
    var buildingName = parameter.slice(1, parameter.length);    

    firestore.collection(collectionName).doc(buildingName).get()
      .then(async (doc) => {
        if (!doc.exists) {
          console.log(`No building found with the name of "${buildingName}"`);
          res.status(404).send(`No building found with the name of "${buildingName}"`);
          return;
        }
        var devices = doc.get("Devices");
        if (devices === undefined || devices === {}){
          res.status(404).send(`No devices connected to building ${buildingName}`);
          return;
        }
        //nu van al deze devices in de array, de nieuwste logs ophalen

        await firestore.collection("deviceLogs").get()
        .then(async (allDocs) => {
          const allDocsData: any[] = [];
          allDocs.docs.forEach((doc: any) => {
            allDocsData.push(doc.data());//first get all the logs
            var thisDoc = allDocsData[allDocsData.length - 1];            
            if (devices[thisDoc.mac] != undefined){//if a log is part of the building it will set some things
              thisDoc.name = devices[thisDoc.mac].name;
              thisDoc.location = devices[thisDoc.mac].location;
              thisDoc.description = devices[thisDoc.mac].description;
              thisDoc.gender = devices[thisDoc.mac].gender;
            }
          });
          var logsOfBuilding =  allDocsData.filter(log => log.mac in devices);//filter only the logs of this building
          var latestLogsPerMac = await getLatestLogPerMac(logsOfBuilding);//get only the latest logs of this building
          res.send(latestLogsPerMac);
        })
        .catch((error) => {
          console.log(error);
          res.status(400).send({err: error.message});
          return;
        })

      })
      .catch((error) => {
        console.log(error);
        res.status(400).send({err: error.message});
      })
  }
);

//localhost:5001/bava-solutions/us-central1/GetStatsOfADevice/DeviceHere
export const GetStatsOfADevice = functions.https.onRequest(
  async (req: functions.https.Request, res: functions.Response) => {
    const firestore = admin.firestore();
    const collectionName = "deviceLogs";
    const parameter = req.params[0];

    await firestore.collection(collectionName).get()
      .then(async (allDocs) => {
        const allDocsData: any[] = [];
        allDocs.docs.forEach((doc) => {
          allDocsData.push(doc.data());//get all the logs
        });
        var groupedLogs = groupBy(allDocsData, "mac");
        var mac = parameter.slice(1, parameter.length);
        var logsOfADevice = groupedLogs[mac];
        var OnlyPPMlogs:any = {};
        
        const LogsWithDate: any[] = [];
        logsOfADevice.forEach((log:any) => {
            log.timestamp = log.timestamp.toDate();
            var PPM = { ppm: log.tvoc_ppm, tijd:  log.timestamp}; //added timestamp for debugging. gets removed in code below
            var key = log.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false });//set the key to local time
            OnlyPPMlogs[key] = PPM;
            log.timestamp = new Date(log.timestamp.toDateString());
            LogsWithDate.push(log);
        });

        var finalPPMLogs:any = {};
        

        var PPMKeys = Object.keys(OnlyPPMlogs);
        console.log(PPMKeys.length);
        
        if (PPMKeys.length > 100){//take only last 100 logs

          for (let index = PPMKeys.length-100; index < PPMKeys.length; index++) {
            const keyIndex = PPMKeys[index];
            finalPPMLogs[keyIndex] = OnlyPPMlogs[keyIndex].ppm;//add the ppm to finallog for ppm
          }
        }
        else {
          for (let index = 0; index < PPMKeys.length; index++) {
            const keyIndex = PPMKeys[index];
            finalPPMLogs[keyIndex] = OnlyPPMlogs[keyIndex].ppm;//add the ppm to finallog for ppm
          }
        }
        

        //only take last 100 of OnlyPPMlogs (eerst orderen op key, dan ze pakken)
        
        var GroupedByDate = groupBy(LogsWithDate, "timestamp");
        var GroupedByDateLengt = Object.keys(GroupedByDate).length;
        
        var objWithDatesAndAvgTemp:any = {};
        var objWithDatesAndTotalVisitors:any = {};
        var objWithDatesAndAvgHumidity:any = {};
        for (let index = 0; index < GroupedByDateLengt; index++) {//1 big calculation for gettings the average stats
          const array = GroupedByDate[Object.keys(GroupedByDate)[index]];          
          var totalTemp = 0;
          var totalVisitors = 0;
          var totalHumidity = 0;
            array.forEach((log:DeviceData) => {
              totalTemp = totalTemp + log.temp;
              totalHumidity = totalHumidity + log.hum;
              if (log.occupied){
                totalVisitors++;
              }
            });
            var avgTemp = totalTemp / array.length;
            var avgHum = totalHumidity / array.length;
            var date = Object.keys(GroupedByDate)[index];
            var dateOnly = new Date(date).toLocaleDateString('en-GB');
            objWithDatesAndAvgTemp[`${dateOnly}`] = avgTemp;
            objWithDatesAndTotalVisitors[`${dateOnly}`] = totalVisitors;
            objWithDatesAndAvgHumidity[`${dateOnly}`] = avgHum;
        }

        var combined = {
          "TotalVisitors": objWithDatesAndTotalVisitors,
          "AverageTemperature": objWithDatesAndAvgTemp,
          "AverageHumidity": objWithDatesAndAvgHumidity,
          "Last100MeasuredPPM": finalPPMLogs
        };

        res.send(combined);
      })
      .catch((error) => {
        console.log(error);
        res.status(400).send({ err: error.message });
      })
  }
);

//Get http://localhost:5001/bava-solutions/us-central1/Login
export const Login = functions.https.onRequest( //Not yet implemented
  async (req: functions.https.Request, res: functions.Response) => {

    // Get username and password. This is stored in authorization headers. encoded in base64
    const { email, password } =extractEmailAndPassword(req);

    // Email & Password & Required Role
    if (!(await authenticateUser(email, password, 3))) {//TODO: role checking can be done with user claims
      res.status(403).send("unauthroized");
      return;
    }

    //user is authorized. now return his JWT token or something
    res.status(200).send("JWT token implementatie, of iets dergelijks, moet nog komen");//TODO: implement tokens

  }
);

//Get http://localhost:5001/bava-solutions/us-central1/GetAllUsers
export const GetAllUsers = functions.https.onRequest( //Testing only
  async (req: functions.https.Request, res: functions.Response) => {
    admin.auth()
    .listUsers(1000)
      .then((userRecords) => {
        userRecords.users.forEach(
            (user) => {
                console.log(user.uid + " - " + user.email);
                console.log(JSON.stringify(user.customClaims));
                console.log("-----------------------------");
            }
        );
    })
    .catch((error) => {
      console.log('Error listing users:', error);
    });
    res.status(200).send("console.log only")
  }
)

//POST http://localhost:5001/bava-solutions/us-central1/giveUserCustomClaim
//BODY: uid
//uid is het uid van een firebaseUser
export const giveUserCustomClaim = functions.https.onRequest(//TODO: only admin of own company can create role for company employees
  async (req: functions.https.Request, res: functions.Response) => {
    var uid = req.body.uid;
    admin.auth()
    .setCustomUserClaims(uid, { company: "Hanz" })//watch out, this overrites all the other custom claims
    .then(() => {
        console.log(`gebruiker: ${uid} heeft nu admin role`);
        res.status(200).send(`gebruiker: ${uid} heeft nu admin role`)
    })
    .catch(()=>{
        console.log(`aanmaken adminrole voor gebruiker: ${uid} is misgegaan`);
        res.status(403).send(`aanmaken adminrole voor gebruiker: ${uid} is misgegaan`)
    });
  }
)

//POST http://localhost:5001/bava-solutions/us-central1/AddUser
//BODY: email, password
export const AddUser = functions.https.onRequest(//TODO: only admin of own company can create role for company employees
  async (req: functions.https.Request, res: functions.Response) => {
    admin.auth()
    .createUser({
      email: req.body.email,
      emailVerified: false,
      password: req.body.password,
      disabled: false,
  })
  .then((userRecord) => {
    // See the UserRecord reference doc for the contents of userRecord.
    console.log('Successfully created new user:', userRecord.uid);
  })
  .catch((error) => {
    console.log('Error creating new user:', error);
  });
  }
)

//POST http://localhost:5001/bava-solutions/us-central1/AddDevice
//BODY: building, name, mac, description, location, gender
export const AddDevice = functions.https.onRequest(//TODO: only admin of own company can add devices
    async (req: functions.https.Request, res: functions.Response) => {
      const firestore = admin.firestore();
      const collectionName = "buildings";

      if (req.method !== "POST") {
        res.status(315).send("Please send a POST request");
        return;
      };
  
      var building = req.body.building;
      var mac = req.body.mac;
      var name = req.body.name;
      var description = req.body.description;
      var location = req.body.location;
      var gender = req.body.gender;
  
      firestore.collection(collectionName).doc(building).get()
        .then((response) => {
          if (!response.exists) {
            console.log(`No building found with the name of "${building}"`);
            res.status(404).send(`No building found with the name of "${building}"`);
            return;
          }
          var devices = response.get("Devices");
          if (devices === undefined){
            devices = {};
          }          
          devices[mac] = {
            name: name,
            description: description,
            location: location,
            gender: gender
          }
          response.ref.update({Devices: devices});
          //always add 1 log so there is alwasy a log available
          var fakedata:any = {
            tvoc_ppm: -1,
            tvoc_co2: -1,
            temp: -1,
            hum: -1,
            occupied: false,
            pressure: -1,
            altitude: -1,
            liquidLevel: -1,
            batteryLevel: -1,
            mac: mac,
          }
          axios.post("https://us-central1-bava-solutions.cloudfunctions.net/AddDeviceData", fakedata)
            .then(() => {
              res.send("Device succesfully added!");
            })
            .catch((error)=>{
              console.log(error);
              res.status(400).send({err: error.message});
            })
          
        })
        .catch((error) => {
          console.log(error);
          res.status(403).send({err: error.message});
        })
  
    }
  )

//POST http://localhost:5001/bava-solutions/us-central1/RemoveDevice
//BODY: building, mac
export const RemoveDevice = functions.https.onRequest(//TODO: only admin of own company can remove devices
    async (req: functions.https.Request, res: functions.Response) => {
      const firestore = admin.firestore();
      const collectionName = "buildings";

      if (req.method !== "POST") {
        res.status(315).send("Please send a POST request");
        return;
      };
  
      var building = req.body.building;
      var mac = req.body.mac;
  
      firestore.collection(collectionName).doc(building).get()
        .then((response) => {
          if (!response.exists) {
            console.log(`No building found with the name of "${building}"`);
            res.status(400).send(`No building found with the name of "${building}"`);
            return;
          } 
          var devices = response.get("Devices");
          delete devices[mac];
          if (Object.keys(devices).length < 1){//if you remove the last device, remove whole object Devices
            response.ref.update({Devices: admin.firestore.FieldValue.delete()});
            res.send("Device succesfully removed!")
          }
          else{
            response.ref.update({Devices: devices});
            res.send("Device succesfully removed!")
          }
          
        })
        .catch((error) => {
          console.log(error);
          res.status(403).send({err: error.message});
        })
  
    }
  )

// Extract Email and Password from the Basic Auth Request
function extractEmailAndPassword(req:functions.https.Request) {
// parse login and password from headers
  const b64auth = (req.headers.authorization || '').split(' ')[1] || ''
  const strauth = Buffer.from(b64auth, 'base64').toString()
  const splitIndex = strauth.indexOf(':')
  const email = strauth.substring(0, splitIndex)
  const password = strauth.substring(splitIndex + 1)

 return {email,password}
}

// Checks FirebaseAuth for a user with 'email' and 'password'
// Then checks the firestore db with the user's uid and checks if user.role >= roleRequired
//
// `webApiKey` isnt private, its ok to put it in the wild
async function authenticateUser(
  email: string,
  password: string,
  roleRequired: number
) {
  const webApiKey = "AIzaSyBSFitnEQRpeWSKnEpLWgTAmXzrWzEF6os";
  const url = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${webApiKey}`;

  try {
    const a:any = await axios.post(url, {
      email,
      password,
      returnSecureToken: true,
    })
      .then((response) => {
        console.log("gaat goed:");
        console.log(response.data);
        return response;
      })
      .catch((error) => {
        console.log("errortje");
        console.log(error);
      });

    const { localId } = a.data as any;

    //functions.logger.log({ d: a.data, localId });

    // Check role.
    const userData = (
      await admin.firestore().collection("users").doc(localId).get()
    ).data();
    //functions.logger.log(userData)
    return userData && userData.role >= roleRequired;
  } catch (err) {
    //functions.logger.error(err);
    return false;
  }
}

var groupBy = function(xs:any, key:any) {
  return xs.reduce(function(rv:any, x:any) {
    (rv[x[key]] = rv[x[key]] || []).push(x);
    return rv;
  }, {});
};

async function getLatestLogPerMac(allDocsData:any) {
  var groupedLogs = groupBy(allDocsData, "mac");

  var onlyNewLogs = new Array();

  Object.keys(groupedLogs).forEach((key: any) => {
    var newestlog:DeviceData = groupedLogs[key][0];
    groupedLogs[key].forEach((element: DeviceData) => {
      if(newestlog.timestamp < element.timestamp){
        newestlog = element;
      }
    });
    onlyNewLogs.push(newestlog);
  });
  return onlyNewLogs;
}


//GET http://localhost:5001/bava-solutions/us-central1/AddRandomLogs
export const AddRandomLogs = functions.https.onRequest(//Testing only
  async (req: functions.https.Request, res: functions.Response) => {
    var data = {
      "tvoc_ppm": 0,
      "tvoc_co2": 0,
      "temp": 0,
      "hum": 0,
      "occupied": false,
      "pressure": 0,
      "altitude": 0,
      "liquidLevel": 0,
      "batteryLevel": 0,
      "mac": "testMAC"
    };
    
    axios.post("http://localhost:5001/bava-solutions/us-central1/AddDeviceData", data)
      .then(() => {
        console.log("toegevoegd");
        res.send("toegevoegd")       
      })
      .catch((error) => {
        console.log(error);
        res.send(error.message)  
      })
  }
);