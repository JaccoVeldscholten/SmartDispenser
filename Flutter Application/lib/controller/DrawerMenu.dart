import 'package:auto_size_text/auto_size_text.dart';
import 'package:bava/auth/auth_util.dart';
import 'package:bava/backend/api_requests/api_calls.dart';
import 'package:bava/flutter_flow/flutter_flow_icon_button.dart';
import 'package:bava/flutter_flow/flutter_flow_theme.dart';
import 'package:bava/flutter_flow/flutter_flow_util.dart';
import 'package:bava/home_overview/home_overview_widget.dart';
import 'package:bava/login/login_widget.dart';
import 'package:bava/new_location/new_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenu createState() => _DrawerMenu();
}

class _DrawerMenu extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: AutoSizeText(
                  currentUserEmail,
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.title3,
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                color: FlutterFlowTheme.highlight,
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                  child: AutoSizeText(
                    'admin'.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: AutoSizeText(
                  'Locations',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.title3,
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 0,
                color: FlutterFlowTheme.highlight,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(),
                child: FutureBuilder<dynamic>(
                  future: GetAllBuildingsCall(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      // Asign var to building
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
                    var listViewGetAllBuildingsResponse = snapshot.data;
                    return Builder(
                      builder: (context) {
                        final buildings = getJsonField(
                                    listViewGetAllBuildingsResponse, r'''$''')
                                ?.toList() ??
                            [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: buildings.length,
                          itemBuilder: (context, buildingsIndex) {
                            var buildingsItem = buildings[buildingsIndex];
                            return FutureBuilder<dynamic>(
                              future: GetAllBuildingsCall(),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
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
                                final textGetAllBuildingsResponse =
                                    snapshot.data;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedBuilding = buildingsItem;

                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                          reverseDuration:
                                              Duration(milliseconds: 0),
                                          child: HomeOverviewWidget(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Text(
                                    getJsonField(buildingsItem, r'''$.''')
                                        .toString(),
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 0,
                color: FlutterFlowTheme.highlight,
              ),
              Container(
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
                        child: NewLocationWidget(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            'Add New Location',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1,
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
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
                              child: NewLocationWidget(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(),
                child: InkWell(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Delete building'),
                        content: Text("Are you sure you want to delete " +
                            selectedBuilding),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              removeBuilding(selectedBuilding);

                              setState(() {});
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                  reverseDuration: Duration(milliseconds: 0),
                                  child: HomeOverviewWidget(),
                                ),
                              );
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            'Remove Location',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1,
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 0,
                        borderWidth: 0,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Color(0xFFFF0000),
                          size: 20,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                              reverseDuration: Duration(milliseconds: 0),
                              child: NewLocationWidget(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 0,
                color: FlutterFlowTheme.highlight,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: InkWell(
                        onTap: () async {
                          await signOut();
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                              reverseDuration: Duration(milliseconds: 0),
                              child: LoginWidget(),
                            ),
                          );
                        },
                        child: AutoSizeText(
                          'Log Out',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.bodyText1,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
