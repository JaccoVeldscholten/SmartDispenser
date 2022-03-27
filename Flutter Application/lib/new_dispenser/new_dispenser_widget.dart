import 'package:bava/controller/DrawerMenu.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_count_controller.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_overview/home_overview_widget.dart';
import '../login/login_widget.dart';
import '../new_location/new_location_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewDispenserWidget extends StatefulWidget {
  NewDispenserWidget({Key key}) : super(key: key);

  @override
  _NewDispenserWidgetState createState() => _NewDispenserWidgetState();
}

class _NewDispenserWidgetState extends State<NewDispenserWidget> {
  String choiceChipsValue;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  int countControllerValue;
  TextEditingController textController4;
  bool _loadingButton = false;
  dynamic newDispenser;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
  }

  String dropdownValue = 'Hanz';

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(
                builder: (context) => HomeOverviewWidget(),
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
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                    reverseDuration: Duration(milliseconds: 0),
                    child: HomeOverviewWidget(),
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Stack(
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                child: Wrap(spacing: 8.0, runSpacing: 4.0, children: <Widget>[
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
                                'New Dispenser',
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
                        padding: EdgeInsetsDirectional.fromSTEB(30, 50, 30, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
                                        borderRadius: BorderRadius.circular(17),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 0, 0),
                                              child: TextFormField(
                                                onChanged: (_) =>
                                                    setState(() {}),
                                                controller: textController1,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Serial Nr.',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText1,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  suffixIcon: textController1
                                                          .text.isNotEmpty
                                                      ? InkWell(
                                                          onTap: () => setState(
                                                            () =>
                                                                textController1
                                                                    .clear(),
                                                          ),
                                                          child: Icon(
                                                            Icons.clear,
                                                            color: FlutterFlowTheme
                                                                .secondaryColor,
                                                            size: 22,
                                                          ),
                                                        )
                                                      : null,
                                                ),
                                                style:
                                                    FlutterFlowTheme.bodyText1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
                                        borderRadius: BorderRadius.circular(17),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 0, 0),
                                              child: TextFormField(
                                                onChanged: (_) =>
                                                    setState(() {}),
                                                controller: textController2,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Name the Dispenser',
                                                  hintStyle: FlutterFlowTheme
                                                      .bodyText1,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  suffixIcon: textController2
                                                          .text.isNotEmpty
                                                      ? InkWell(
                                                          onTap: () => setState(
                                                            () =>
                                                                textController2
                                                                    .clear(),
                                                          ),
                                                          child: Icon(
                                                            Icons.clear,
                                                            color: FlutterFlowTheme
                                                                .secondaryColor,
                                                            size: 22,
                                                          ),
                                                        )
                                                      : null,
                                                ),
                                                style:
                                                    FlutterFlowTheme.bodyText1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
                                        borderRadius: BorderRadius.circular(17),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: FutureBuilder<dynamic>(
                                                future: GetAllBuildingsCall(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    // Asign var to building
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child:
                                                            SpinKitChasingDots(
                                                          color:
                                                              Color(0xFF70C7AC),
                                                          size: 25,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  var listViewGetAllBuildingsResponse =
                                                      snapshot.data;

                                                  final buildings = getJsonField(
                                                              listViewGetAllBuildingsResponse,
                                                              r'''$''')
                                                          ?.toList() ??
                                                      [];

                                                  //print(buildings);
                                                  return DropdownButton<String>(
                                                    dropdownColor:  Color(0xFF6C7181),                                                    value: dropdownValue,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    iconSize: 24,
                                                    elevation: 60,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.white),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue;
                                                      });
                                                    },
                                                    items: buildings
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>((value) =>
                                                            new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: new Text(
                                                                  value),
                                                            ))
                                                        .toList(),
                                                  );
                                                }),
                                          )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
                                        borderRadius: BorderRadius.circular(17),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 5, 0),
                                            child: Text(
                                              'Floor',
                                              style: FlutterFlowTheme.bodyText1,
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme
                                                  .buttonSeethrough,
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: FlutterFlowTheme
                                                    .buttonSeethrough,
                                                width: 0,
                                              ),
                                            ),
                                            child: FlutterFlowCountController(
                                              decrementIconBuilder: (enabled) =>
                                                  FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: enabled
                                                    ? Color(0xFF70C7AC)
                                                    : FlutterFlowTheme
                                                        .tertiaryColor,
                                                size: 15,
                                              ),
                                              incrementIconBuilder: (enabled) =>
                                                  FaIcon(
                                                FontAwesomeIcons.plus,
                                                color: enabled
                                                    ? Color(0xFF70C7AC)
                                                    : FlutterFlowTheme
                                                        .tertiaryColor,
                                                size: 15,
                                              ),
                                              countBuilder: (count) => Text(
                                                count.toString(),
                                                style: GoogleFonts.getFont(
                                                  'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              count: countControllerValue ??= 0,
                                              updateCount: (count) => setState(
                                                  () => countControllerValue =
                                                      count),
                                              stepSize: 1,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 15, 0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(35, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FlutterFlowChoiceChips(
                                initialOption: choiceChipsValue ??= 'Both',
                                options: [
                                  ChipData('Both', Icons.wc_outlined),
                                  ChipData('Male', FontAwesomeIcons.male),
                                  ChipData('Female', FontAwesomeIcons.female)
                                ],
                                onChanged: (val) =>
                                    setState(() => choiceChipsValue = val),
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.buttonSeethrough,
                                  textStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mulish',
                                    color: FlutterFlowTheme.highlight,
                                  ),
                                  iconColor: FlutterFlowTheme.highlight,
                                  iconSize: 20,
                                  elevation: 4,
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.buttonSeethrough,
                                  textStyle: FlutterFlowTheme.bodyText1,
                                  iconColor: FlutterFlowTheme.tertiaryColor,
                                  iconSize: 20,
                                  elevation: 4,
                                ),
                                chipSpacing: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: 300,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
                                        borderRadius: BorderRadius.circular(17),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, -1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 0, 20, 0),
                                                child: TextFormField(
                                                  onChanged: (_) =>
                                                      setState(() {}),
                                                  controller: textController4,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Additional Comment',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText1,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    suffixIcon: textController4
                                                            .text.isNotEmpty
                                                        ? InkWell(
                                                            onTap: () =>
                                                                setState(
                                                              () =>
                                                                  textController4
                                                                      .clear(),
                                                            ),
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: FlutterFlowTheme
                                                                  .secondaryColor,
                                                              size: 22,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText1,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, -1),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 30,
                                              icon: FaIcon(
                                                FontAwesomeIcons.questionCircle,
                                                color: FlutterFlowTheme
                                                    .secondaryColor,
                                                size: 15,
                                              ),
                                              onPressed: () async {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Add aditional comments, for example where the bathroom is located for easier localization',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Mulish',
                                                        color: FlutterFlowTheme
                                                            .tertiaryColor,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 10000),
                                                    backgroundColor:
                                                        FlutterFlowTheme
                                                            .secondaryColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() => _loadingButton = true);
                                      int gender;
                                      switch (choiceChipsValue) {
                                        case "Male":
                                          gender = 1;
                                          break;
                                        case "Female":
                                          gender = 2;
                                          break;
                                        default:
                                          gender = 0;
                                          break;
                                      }
                                      try {
                                        //print(choiceChipsValue);
                                        newDispenser = await AddDeviceCall(
                                          mac: textController1.text,
                                          name: textController2.text,
                                          building: dropdownValue,
                                          location:
                                              countControllerValue.toString(),
                                          gender: gender,
                                          description: textController4.text,
                                        );
                                        //print("Lets fetch some data!!!!!!!!");
                                        //print(newDispenser);
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                            reverseDuration:
                                                Duration(milliseconds: 0),
                                            child: HomeOverviewWidget(),
                                          ),
                                        );

                                        setState(() {});
                                      } finally {
                                        setState(() => _loadingButton = false);
                                      }
                                    },
                                    text: 'Add Dispenser',
                                    options: FFButtonOptions(
                                      width: 150,
                                      height: 40,
                                      color: FlutterFlowTheme.buttonSeethrough,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mulish',
                                        color: FlutterFlowTheme.tertiaryColor,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                      borderRadius: 17,
                                    ),
                                    loading: _loadingButton,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
