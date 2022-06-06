import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user_app/authScreens/login_tab_page.dart';
import 'package:user_app/authScreens/registration_tab_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(
     flexibleSpace: Container(
         decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 1, 23, 60),
                      Color.fromARGB(168, 41, 39, 193),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)
                    ),

                    
     ),
title:  Text(" At Safeway ", style: TextStyle(fontSize:  20 , fontWeight:  FontWeight.bold),
),
centerTitle: true, 
 shadowColor: Colors.black,

 bottom:  TabBar(
   indicatorColor: Colors.white,
   //isScrollable: true,
   automaticIndicatorColorAdjustment: true,
   
   
   tabs: [
   Tab(
     text: "Login",
     icon:  Icon(Icons.lock , color:  Colors.white,),
    
   ),
   Tab(
     text: "Registration",
     icon:  Icon(Icons.person , color:  Colors.white,),
    
   )
 ]),
    ),
    body: Container(
child:  TabBarView(children: [
  LoginTabPage(),
  RegistrationTabPage(),

]),
    ),
    )

    );
    
  }
}