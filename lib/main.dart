import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:refapp/Providers/ValidationProvider.dart';
import 'package:refapp/UI/loginscreen.dart';

import 'UI/HomeScreen.dart';
import 'UI/registartionscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<authenticationProvider>(
            create: (context) => authenticationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'referal system',
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) =>  SplashScreen(),
          RegistrationScreen.routeName: (context) => RegistrationScreen(),
          LoginScreen.routeName:(context)=> LoginScreen(),
          HomeScreen.routeName:(context)=> HomeScreen(),

        },
      ),

    );
  }
}

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(

          context, MaterialPageRoute(builder: (context) => RegistrationScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/logo.png"),

      ),
    );
  }
}
