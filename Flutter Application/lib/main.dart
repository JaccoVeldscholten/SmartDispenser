import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/firebase_user_provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:bava/login/login_widget.dart';
import 'package:bava/home_overview/home_overview_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<BavaFirebaseUser> userStream;
  BavaFirebaseUser initialUser;

  @override
  void initState() {
    super.initState();
    userStream = bavaFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAVA',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialUser == null
          ? Container(
              color: FlutterFlowTheme.primaryColor,
              child: Center(
                child: Builder(
                  builder: (context) => Image.asset(
                    'assets/images/Logo_Medium.png',
                    width: MediaQuery.of(context).size.width * 0.75,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )
          : currentUser.loggedIn
              ? HomeOverviewWidget()
              : LoginWidget(),
    );
  }
}
