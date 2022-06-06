import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user_app/authScreens/auth_screen.dart';
import 'package:user_app/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  splashScreenTimer(){

    
    Timer(const Duration(seconds: 4),  () async{
      //user is already logged in 
      if(FirebaseAuth.instance.currentUser != null){
 Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));

      }else{
        // user is not logged in 
         Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));

      }
     
    });
  }

  @override 
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreenTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 1, 23, 60),
                  Color.fromARGB(168, 41, 39, 193),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
       
       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
             
              
              margin: EdgeInsets.all(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                 
              ),
              
              
              child: Image.asset("assets/images/logo1.jpg"),
             
              ),
            SizedBox(height: 10,),
            Container(
              child: Row(
          
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 10.0, height: 100.0),
            const Text(
              'Welcom to',
              style: TextStyle(fontSize: 20.0, color: Colors.white,),
            ),
            const SizedBox(width: 10.0, height: 100.0),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
                fontFamily: 'Horizon',
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('At Safeway'),
                  RotateAnimatedText('At Safeway'),
                  RotateAnimatedText('At Safeway'),
                ],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen(),));
                },
              ),
            ),
          ],
        ),
            )
          ],
        ),
      ),
    );
  }
}
