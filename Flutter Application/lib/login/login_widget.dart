import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../forgot_password/forgot_password_widget.dart';
import '../home_overview/home_overview_widget.dart';
import '../sign_up/sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  bool passwordVisibility;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.primaryColor,
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
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                            child: Image.asset(
                              'assets/images/Logo_Medium.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 30, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'SmartDispenser',
                                style: FlutterFlowTheme.title2.override(
                                  fontFamily: 'Raleway',
                                  color: FlutterFlowTheme.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Container(
                                        width: 300,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color:
                                              FlutterFlowTheme.buttonSeethrough,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                  controller:
                                                      emailTextController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'E-Mail Adress',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText1,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
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
                                                        width: 1,
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
                                                    suffixIcon:
                                                        emailTextController
                                                                .text.isNotEmpty
                                                            ? InkWell(
                                                                onTap: () =>
                                                                    setState(
                                                                  () => emailTextController
                                                                      .clear(),
                                                                ),
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  color: Color(
                                                                      0xFF757575),
                                                                  size: 22,
                                                                ),
                                                              )
                                                            : null,
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText1,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  validator: (val) {
                                                    if (val.isEmpty) {
                                                      return 'Field is required';
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 20, 0),
                                              child: Icon(
                                                Icons.person,
                                                color:
                                                    FlutterFlowTheme.highlight,
                                                size: 24,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Container(
                                        width: 300,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color:
                                              FlutterFlowTheme.buttonSeethrough,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                  onFieldSubmitted: (_) async {
                                                    if (!formKey.currentState
                                                        .validate()) {
                                                      return;
                                                    }
                                                    final user =
                                                        await signInWithEmail(
                                                      context,
                                                      emailTextController.text,
                                                      passwordTextController
                                                          .text,
                                                    );
                                                    if (user == null) {
                                                      return;
                                                    }

                                                    await Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeOverviewWidget(),
                                                      ),
                                                      (r) => false,
                                                    );
                                                  },
                                                  controller:
                                                      passwordTextController,
                                                  obscureText:
                                                      !passwordVisibility,
                                                  decoration: InputDecoration(
                                                    hintText: 'Password',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText1,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
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
                                                        width: 1,
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
                                                    suffixIcon: InkWell(
                                                      onTap: () => setState(
                                                        () => passwordVisibility =
                                                            !passwordVisibility,
                                                      ),
                                                      child: Icon(
                                                        passwordVisibility
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        color: FlutterFlowTheme
                                                            .buttonSeethrough,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText1,
                                                  validator: (val) {
                                                    if (val.isEmpty) {
                                                      return 'Field is required';
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 20, 0),
                                              child: Icon(
                                                Icons.lock_outlined,
                                                color:
                                                    FlutterFlowTheme.highlight,
                                                size: 24,
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
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.5, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        setState(() => _loadingButton1 = true);
                                        try {
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                              reverseDuration:
                                                  Duration(milliseconds: 0),
                                              child: SignUpWidget(),
                                            ),
                                          );
                                        } finally {
                                          setState(
                                              () => _loadingButton1 = false);
                                        }
                                      },
                                      text: 'Sign Up',
                                      options: FFButtonOptions(
                                        width: 90,
                                        height: 40,
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
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
                                      loading: _loadingButton1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(-0.5, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        setState(() => _loadingButton2 = true);
                                        try {
                                          if (!formKey.currentState
                                              .validate()) {
                                            return;
                                          }
                                          final user = await signInWithEmail(
                                            context,
                                            emailTextController.text,
                                            passwordTextController.text,
                                          );
                                          if (user == null) {
                                            return;
                                          }

                                          await Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeOverviewWidget(),
                                            ),
                                            (r) => false,
                                          );
                                        } finally {
                                          setState(
                                              () => _loadingButton2 = false);
                                        }
                                      },
                                      text: 'Log In',
                                      options: FFButtonOptions(
                                        width: 90,
                                        height: 40,
                                        color:
                                            FlutterFlowTheme.buttonSeethrough,
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
                                      loading: _loadingButton2,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                      reverseDuration:
                                          Duration(milliseconds: 0),
                                      child: ForgotPasswordWidget(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot your password?',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mulish',
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
