import 'package:bava/controller/DrawerMenu.dart';
import 'package:bava/details/details_widget.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login/login_widget.dart';
import '../new_dispenser/new_dispenser_widget.dart';
import '../new_location/new_location_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/WidgetIconDecider.dart';

class HomeOverviewWidget extends StatefulWidget {
  HomeOverviewWidget({Key key}) : super(key: key);

  @override
  _HomeOverviewWidgetState createState() => _HomeOverviewWidgetState();
}

String selectedBuilding = "Hanz";

class _HomeOverviewWidgetState extends State<HomeOverviewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(),
            child: Image.asset(
              'assets/images/Logo_Medium.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
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
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFF0E132C),
            ),
            child: Align(
              alignment: AlignmentDirectional(1, 1),
              child: Image.asset(
                'assets/images/Side_ornament_App.png',
                width: MediaQuery.of(context).size.width * 0.75,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 50, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        selectedBuilding,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Overview',
                      style: FlutterFlowTheme.bodyText1,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                  child: FutureBuilder<dynamic>(
                    future: GetDeviceStatusPerBuildingCall(selectedBuilding),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      //print(snapshot.data);
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: SpinKitChasingDots(
                              color: Color(0xFF70C7AC),
                              size: 25,
                            ),
                          ),
                        );
                      }
                      final gridViewGetDeviceStatusPerBuildingResponse =
                          snapshot.data;

                      // print(gridViewGetDeviceStatusPerBuildingResponse);

                      return Builder(
                        builder: (context) {
                          var devices;

                          if (snapshot.data.toString().length > 2) {
                            if (snapshot.data[0] != null) {
                              if (snapshot.hasData) {
                                //print(gridViewGetDeviceStatusPerBuildingResponse);
                                devices = getJsonField(
                                        gridViewGetDeviceStatusPerBuildingResponse,
                                        r'''$''')
                                    .toList();

                                print(devices);
                              } else {
                                devices = [];
                                return Text(
                                    "No devices attached to account. Add devices below.",
                                    style: TextStyle(color: Colors.white));
                              }
                            } else {
                              devices = [];
                              return Text(
                                  "No devices attached to account. Add devices below.",
                                  style: TextStyle(color: Colors.white));
                            }
                          } else {
                            devices = [];
                            return Text(
                                "Error in API please contact administrator Fokke",
                                style: TextStyle(color: Colors.white));
                          }

                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: devices.length,
                            itemBuilder: (context, devicesIndex) {
                              final devicesItem = devices[devicesIndex];

                              return GestureDetector(
                                // When clicked the screen
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailsWidget(
                                          device: devicesItem,
                                          buildingName: selectedBuilding))),
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.buttonSeethrough,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        getJsonField(devicesItem, r'''$.name''')
                                            .toString(),
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(2, 2, 2,
                                                                2),
                                                    child: Container(
                                                        width: 100,
                                                        height: 100,
                                                        child: occupiedIconWidget(
                                                            getJsonField(
                                                                devicesItem,
                                                                r'''$.occupied'''),
                                                            getJsonField(
                                                                devicesItem,
                                                                r'''$.gender''')))),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 2, 2, 2),
                                                  child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: liquidIconWidget(
                                                          getJsonField(
                                                              devicesItem,
                                                              r'''$.liquidLevel'''))),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 2, 2, 2),
                                                  child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: batteryIconWidget(
                                                          getJsonField(
                                                              devicesItem,
                                                              r'''$.batteryLevel'''))),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 2, 2, 2),
                                                  child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: airQualityIconWidget(
                                                          getJsonField(
                                                              devicesItem,
                                                              r'''$.tvoc_ppm'''))),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 160, 150),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                          reverseDuration: Duration(milliseconds: 0),
                          child: NewDispenserWidget(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            'Add New Dispenser',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 0,
                            borderWidth: 0,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: FlutterFlowTheme.highlight,
                              size: 20,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                  reverseDuration: Duration(milliseconds: 0),
                                  child: NewDispenserWidget(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
