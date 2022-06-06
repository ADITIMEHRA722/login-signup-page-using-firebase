import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/authScreens/auth_screen.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/home_screen.dart';
import 'package:user_app/splachScreen/my_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()  async{

  WidgetsFlutterBinding.ensureInitialized();
 sharedPreferences = await SharedPreferences.getInstance();
   await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.indigo,
      ),
      home: MySplashScreen(),
    );
  }
}

