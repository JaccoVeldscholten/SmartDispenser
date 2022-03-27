import 'package:bava/controller/DrawerMenu.dart';
import 'package:bava/model/GraphStenchData.dart';
import 'package:bava/model/GraphVisitorsData.dart';
import 'package:bava/new_dispenser/new_dispenser_widget.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../home_overview/home_overview_widget.dart';
import '../login/login_widget.dart';
import '../new_location/new_location_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/WidgetIconDecider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../model/GraphTempData.dart';
import '../model/GraphHumData.dart';

class DetailsWidget extends StatefulWidget {
  final dynamic device;
  final String buildingName;

  DetailsWidget({Key key, this.device, this.buildingName}) : super(key: key);

  @override
  _DetailsWidgetState createState() =>
      _DetailsWidgetState(device, buildingName);
}

Future<String> getJsonFromAssets(String mac) async {
  // https://us-central1-bava-solutions.cloudfunctions.net/GetAllLatestDeviceData

  final response = await http.get(Uri.parse(
      'https://us-central1-bava-solutions.cloudfunctions.net/GetStatsOfADevice/.' +
          mac));
  if (response.statusCode == 200) {
    //ToDo: Fault handling
    // print(response.body);
  }
  return response.body;
}

class _DetailsWidgetState extends State<DetailsWidget> {
  final dynamic device; // Parsing values
  final String buildingName; // Building name needed for removal
  _DetailsWidgetState(this.device, this.buildingName); // Parsing values

  List<GraphVisitorsData> chartDataVisitors = [];
  List<GraphStenchData> chartDataStench = [];
  List<GraphTempData> chartDataTemp = [];
  List<GraphHumData> chartDataHum = [];

  Future loadGraphDataVisitors(String mac) async {
    chartDataVisitors.clear(); // Clear old data
    final String jsonString = await getJsonFromAssets(mac);

    Map<String, dynamic> decoded = json.decode(jsonString);

    for (var date in decoded['TotalVisitors'].keys) {
      chartDataVisitors
          .add(GraphVisitorsData(date, decoded['TotalVisitors'][date].round()));
    }
  }

  Future loadGraphDataStench(String mac) async {
    chartDataStench.clear(); // Clear old data
    final String jsonString = await getJsonFromAssets(mac);

    Map<String, dynamic> decoded = json.decode(jsonString);

    //print(decoded);
    for (var date in decoded['Last100MeasuredPPM'].keys) {
      chartDataStench
          .add(GraphStenchData(date, decoded['Last100MeasuredPPM'][date]));
    }
  }

  Future loadGraphDataTemp(String mac) async {
    chartDataTemp.clear(); // Clear old data
    final String jsonString = await getJsonFromAssets(mac);

    Map<String, dynamic> decoded = json.decode(jsonString);

    for (var date in decoded['AverageTemperature'].keys) {
      chartDataTemp.add(
          GraphTempData(date, decoded['AverageTemperature'][date].round()));
    }
  }

  Future loadGraphDataHum(String mac) async {
    chartDataHum.clear(); // Clear old data
    final String jsonString = await getJsonFromAssets(mac);

    Map<String, dynamic> decoded = json.decode(jsonString);

    for (var date in decoded['AverageHumidity'].keys) {
      chartDataHum
          .add(GraphHumData(date, decoded['AverageHumidity'][date].round()));
    }
  }

  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //print("Building " + buildingName);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back,
            color: FlutterFlowTheme.tertiaryColor,
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
                reverseDuration: Duration(milliseconds: 0),
                child: HomeOverviewWidget(),
              ),
            );
          },
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeOverviewWidget(),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/Logo_Medium.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 20,
      ),
      backgroundColor: FlutterFlowTheme.primaryColor,
      endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.6, child: DrawerMenu()),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
        child: Wrap(spacing: 8.0, runSpacing: 4.0, children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        device["name"],
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.title1.override(
                          fontFamily: 'Raleway',
                          color: FlutterFlowTheme.tertiaryColor,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    device["description"],
                    style: FlutterFlowTheme.bodyText1,
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Text(
                        device["mac"],
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Mulish',
                          color: FlutterFlowTheme.highlight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  child: Stack(
                    children: [
                      PageView(
                        controller: pageViewController ??=
                            PageController(initialPage: 0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  "Floor " + device["location"],
                                  style: FlutterFlowTheme.title3,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  genderText(device["gender"]),
                                  style: FlutterFlowTheme.bodyText1,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Text(
                                    'Status',
                                    style: FlutterFlowTheme.title3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    occupiedIconWidget(
                                        device["occupied"], device["gender"]),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        occupiedText(device["occupied"]),
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    airQualityIconWidget(device["tvoc_ppm"]),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        smellText(device["tvoc_ppm"]),
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    liquidIconWidget(device["liquidLevel"]),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        'Liquid Level',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        device["liquidLevel"] < 0
                                            ? "No logs registered yet "
                                            : device["liquidLevel"].toString() +
                                                "%",
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mulish',
                                          color: FlutterFlowTheme.highlight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    batteryIconWidget(device["batteryLevel"]),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        'Power Level',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        device["batteryLevel"] < 0
                                            ? "No logs registered yet "
                                            : device["batteryLevel"]
                                                    .toString() +
                                                "%",
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mulish',
                                          color: FlutterFlowTheme.highlight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    tempIconWidget(device["temp"]),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        'Temperature',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        device["temp"] < 0
                                            ? "No logs registered yet "
                                            : device["temp"].toString() + " °C",
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mulish',
                                          color: FlutterFlowTheme.highlight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    humIconWidget(device["hum"]),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        'Humidity',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          35, 0, 0, 0),
                                      child: Text(
                                        device["hum"] < 0
                                            ? "No logs registered yet "
                                            : device["hum"].toString() + "%",
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mulish',
                                          color: FlutterFlowTheme.highlight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.alarm,
                                      color: Color(0xff70C7AC),
                                      size: 40.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 0, 0, 0),
                                      child: Text(
                                        device["hum"] < 0
                                            ? "No logs registered yet "
                                            : // Getting random value of first log

                                            "Updated " +
                                                DateFormat(
                                                        'kk:mm on dd-MM-yyyy')
                                                    .format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            device["timestamp"][
                                                                    "_seconds"] *
                                                                1000))
                                                    .toString(),
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            200, 0, 0, 0),
                                        child: ElevatedButton(
                                          child: Text("REMOVE DEVICE",
                                              style: TextStyle(fontSize: 10)),
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.red),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(color: Colors.red)))),
                                          onPressed: () => {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                    'Delete building'),
                                                content: Text(
                                                    "Are you sure you want to delete " +
                                                        device['name']),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {

                                                        RemoveDeviceFromAccount(
                                                            buildingName,
                                                            device['mac']);
                                                      setState(() async {
                                                        await Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                HomeOverviewWidget(),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            )
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  'Technical Data',
                                  style: FlutterFlowTheme.title3,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Text(
                                    'Visitors over time',
                                    style: FlutterFlowTheme.title3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: FutureBuilder(
                                      future:
                                          loadGraphDataVisitors(device['mac']),
                                      builder: (context, snapshot) {
                                        //print(chartDataVisitors);
                                        if (chartDataVisitors.isNotEmpty) {
                                          return SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              // Chart title
                                              series: <
                                                  ChartSeries<GraphVisitorsData,
                                                      String>>[
                                                LineSeries<GraphVisitorsData,
                                                    String>(
                                                  color: Colors.greenAccent,
                                                  dataSource: chartDataVisitors,
                                                  xValueMapper:
                                                      (GraphVisitorsData
                                                                  graphData,
                                                              _) =>
                                                          graphData.date,
                                                  yValueMapper:
                                                      (GraphVisitorsData
                                                                  graphData,
                                                              _) =>
                                                          graphData.amount,
                                                )
                                              ]);
                                        } else {
                                          return ClipRRect(
                                            child: Container(
                                              height: 100,
                                              width: 400,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text('Loading data...',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white)),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        semanticsLabel:
                                                            'Loading data',
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors
                                                                    .greenAccent),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Text(
                                    'Air quality over time',
                                    style: FlutterFlowTheme.title3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: FutureBuilder(
                                      future:
                                          loadGraphDataStench(device['mac']),
                                      builder: (context, snapshot) {
                                        //print(chartDataStench);
                                        if (chartDataStench.isNotEmpty) {
                                          return SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              // Chart title
                                              series: <
                                                  ChartSeries<GraphStenchData,
                                                      String>>[
                                                LineSeries<GraphStenchData,
                                                    String>(
                                                  color: Colors.greenAccent,
                                                  dataSource: chartDataStench,
                                                  xValueMapper: (GraphStenchData
                                                              graphData,
                                                          _) =>
                                                      graphData.date,
                                                  yValueMapper: (GraphStenchData
                                                              graphData,
                                                          _) =>
                                                      graphData.tvoc,
                                                )
                                              ]);
                                        } else {
                                          return ClipRRect(
                                            child: Container(
                                              height: 100,
                                              width: 400,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text('Loading data...',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white)),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        semanticsLabel:
                                                            'Loading data',
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors
                                                                    .greenAccent),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  'Technical Data',
                                  style: FlutterFlowTheme.title3,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Text(
                                    'Temperature over time',
                                    style: FlutterFlowTheme.title3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: FutureBuilder(
                                      future: loadGraphDataTemp(device['mac']),
                                      builder: (context, snapshot) {
                                        //print(chartDataTemp);
                                        if (chartDataTemp.isNotEmpty) {
                                          return SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              // Chart title
                                              series: <
                                                  ChartSeries<GraphTempData,
                                                      String>>[
                                                LineSeries<GraphTempData,
                                                    String>(
                                                  color: Colors.greenAccent,
                                                  dataSource: chartDataTemp,
                                                  xValueMapper:
                                                      (GraphTempData graphData,
                                                              _) =>
                                                          graphData.date,
                                                  yValueMapper:
                                                      (GraphTempData graphData,
                                                              _) =>
                                                          graphData.temp,
                                                )
                                              ]);
                                        } else {
                                          return ClipRRect(
                                            child: Container(
                                              height: 100,
                                              width: 400,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text('Loading data...',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white)),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        semanticsLabel:
                                                            'Loading data',
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors
                                                                    .greenAccent),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Text(
                                    'Humidity over time',
                                    style: FlutterFlowTheme.title3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: FutureBuilder(
                                      future: loadGraphDataHum(device['mac']),
                                      builder: (context, snapshot) {
                                        //print(chartDataHum);
                                        if (chartDataHum.isNotEmpty) {
                                          return SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              // Chart title
                                              series: <
                                                  ChartSeries<GraphHumData,
                                                      String>>[
                                                LineSeries<GraphHumData,
                                                    String>(
                                                  color: Colors.greenAccent,
                                                  dataSource: chartDataHum,
                                                  xValueMapper:
                                                      (GraphHumData graphData,
                                                              _) =>
                                                          graphData.date,
                                                  yValueMapper:
                                                      (GraphHumData graphData,
                                                              _) =>
                                                          graphData.hum,
                                                )
                                              ]);
                                        } else {
                                          return ClipRRect(
                                            child: Container(
                                              height: 100,
                                              width: 400,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text('Loading data...',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white)),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        semanticsLabel:
                                                            'Loading data',
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors
                                                                    .greenAccent),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0,0.35),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: SmoothPageIndicator(
                            controller: pageViewController ??=
                                PageController(initialPage: 0),
                            count: 3,
                            axisDirection: Axis.horizontal,
                            onDotClicked: (i) {
                              pageViewController.animateToPage(
                                i,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            effect: ExpandingDotsEffect(
                              expansionFactor: 2,
                              spacing: 8,
                              radius: 16,
                              dotWidth: 16,
                              dotHeight: 16,
                              dotColor: Color(0xFF6C6F7F),
                              activeDotColor: FlutterFlowTheme.highlight,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
