import 'api_manager.dart';

Future<dynamic> GetDeviceStatusPerBuildingCall(String building) {
  //print("Fetch API for building: " + building);
  return ApiManager.instance.makeApiCall(
    callName: 'GetDeviceStatusPerBuilding',
    apiUrl:
        'https://us-central1-bava-solutions.cloudfunctions.net/GetDeviceStatusPerBuilding/h' +
            building,
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> RemoveDeviceFromAccount(String building, String mac) {
  //print(building);
  //print("Device is getting deleted " + mac + "Building: ");
  final body = '''
{
    "building": "$building",
    "mac": "$mac"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'Add Device',
    apiUrl:
        'https://us-central1-bava-solutions.cloudfunctions.net/RemoveDevice',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> addBuilding(
    String buildingName, String companyName, String address) {
  //print(buildingName);
  print("Building is getting added: " +
      buildingName +
      " comapny: " +
      companyName +
      " adress: " +
      address);
  final body = '''
{
    "buildingName" : "$buildingName",
    "companyName" : "$companyName",
    "address" : "$address"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'Add Device',
    apiUrl: 'https://us-central1-bava-solutions.cloudfunctions.net/AddLocation',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> removeBuilding(String building) {
  //print(building);
  //print("Building is getting deleted: " + building);
  final body = '''
{
    "buildingName": "$building"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'Add Device',
    apiUrl:
        'https://us-central1-bava-solutions.cloudfunctions.net/RemoveLocation',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> GetAllBuildingsCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'Get all buildings',
    apiUrl:
        'https://us-central1-bava-solutions.cloudfunctions.net/GetAllBuildings',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getDataFromAllSensorsCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Data from All Sensors',
    apiUrl:
        'https://us-central1-bava-solutions.cloudfunctions.net/GetAllDeviceData/',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> AddDeviceCall({

  String building = '',
  int gender = 0,
  String name = '',
  String mac = '',
  String location = '',

  String description = '',
}) {
  final body = '''
{
    "building": "${building}",
    "gender": ${gender},
    "name": "${name}",
    "mac": "${mac}",
    "description": "${description}",
    "location": "${location}"

}''';
  return ApiManager.instance.makeApiCall(
    callName: 'Add Device',
    apiUrl: 'https://us-central1-bava-solutions.cloudfunctions.net/AddDevice',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: false,
  );
}
