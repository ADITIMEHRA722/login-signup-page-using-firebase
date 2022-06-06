import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/authScreens/auth_screen.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/splachScreen/my_splash_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black45 ,
      child: ListView(
        children: [
          //header

          Container(
            padding: const EdgeInsets.only(
              top: 26,
              bottom: 12,
            ),
            child: Column(children: [
              SizedBox(
                height: 120,
                width: 120,
                child:  CircleAvatar(
                  // backgroundImage: NetworkImage(
                 
                  //     "https://images.unsplash.com/photo-1644982647711-9129d2ed7ceb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"),
               backgroundImage: NetworkImage(
                 sharedPreferences!.getString("photoUrl")!,
               ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
               Text(
               sharedPreferences!.getString("name")!,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ]),
          ),

          //body

          Container(
            padding: const EdgeInsets.only(
              top: 1,
            ),
            child: Column(
              children: [
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                // home
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {},
                ),

                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                // my orders
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "My Order",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {

                     
                  },
                ),

                

                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                // history 
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "History",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {

                  },
                ),


                

                
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
               // logout button 
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Sign out",
                    style: TextStyle(color: Colors.grey),
                  ),
                 
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
