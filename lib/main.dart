import 'package:flutter/material.dart';
import 'package:untitled/screens/About.dart';
import 'package:untitled/screens/FeedBack.dart';
import 'package:untitled/screens/NearBy.dart';
import 'package:untitled/screens/Profile.dart';
import 'package:untitled/screens/loginScreen.dart';
import 'package:untitled/screens/mainScreen.dart';
import 'package:untitled/screens/parkCarScreen.dart';
import 'package:untitled/screens/registerScreen.dart';
import 'package:untitled/screens/scanPage.dart';
import 'package:untitled/screens/unParkCarScreen.dart';
import 'package:untitled/screens/verifyScreen.dart';
import 'package:untitled/screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkIT',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        VerifyScreen.id: (context) => VerifyScreen(),
        ScanPage.id: (context) => ScanPage(),
        FeedBack.id: (context) => FeedBack(),
        ParkCarScreen.id: (context) => ParkCarScreen(),
        UnParkCarScreen.id: (context) => UnParkCarScreen(),
        About.id: (context) => About(),
        NearBy.id: (context) => NearBy(),
        Profile.id: (context) => Profile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
