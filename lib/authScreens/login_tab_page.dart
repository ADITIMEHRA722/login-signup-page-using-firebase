import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/home_screen.dart';
import 'package:user_app/splachScreen/my_splash_screen.dart';
import 'package:user_app/widgets/custom_text_field.dart';

import '../widgets/loading_dialog.dart';

class LoginTabPage extends StatefulWidget {
  const LoginTabPage({Key? key}) : super(key: key);

  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  validateForm(){
    if(emailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty)
    {
      // allow the user to login
      loginNow();
    }else{
      Fluttertoast.showToast(msg: "Please provide the Email and Password");
    }
  }
  loginNow() async{

    showDialog(
                context: context,
                 builder: (c){
                  return LoadungDailog(
                message: "Chechking Credentials",
              );
                 }
                 ); 
                 // authenticate

 User ? currentUser;

await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailEditingController.text.trim(),
            password: passwordEditingController.text.trim(),)
        .then((auth) {
          currentUser= auth.user;
        }).catchError((errorMessage) {
          Navigator.pop(context);

          Fluttertoast.showToast(msg: "Error Ocurred: /n $errorMessage");

        });

        if(currentUser != null){
          checkIfUserRecordExist(currentUser!);
        }

  }
  

  checkIfUserRecordExist( User  currentUser) async{

    await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get().then((record) async {
    if(record.exists)// record exist
    {
      // status is approved
      if(record.data()!["status"]=="approved"){
 await sharedPreferences!.setString("uid",record.data()!["uid"]);
    await sharedPreferences!.setString("email",record.data()!["email"]);
    await sharedPreferences!.setString("name",record.data()!["name"]);
    await sharedPreferences!.setString("photoUrl",record.data()!["photoUrl"]);

    List<String> userCartList =record.data()!["userCart"].cast<String>();
    await sharedPreferences!.setStringList("userCart", userCartList);

        //send user to the home paage
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
      }else // status is not approved
    {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "You have blocked by admin/n contact the admin: atshop@gmail.com");
    }

    }else // record do not exist
    {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "This record do not exist");
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network("https://c.ndtvimg.com/2022-03/jcliv9dg_shahi-paneer_625x300_15_March_22.jpg?im=FaceCrop,algorithm=dnn,width=1200,height=886",
              height: MediaQuery.of(context).size.height *0.35,),
            )
            ,Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: emailEditingController,
                      hintText: "Enter Email",
                      enabled: true,
                      iconData: Icons.person,
                      isObscure: false,
                    ),
                    CustomTextField(
                      textEditingController: passwordEditingController,
                      hintText: "Password",
                      enabled: true,
                      iconData: Icons.lock,
                      isObscure: false,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )),


            SizedBox(
              height: 50,
              width: 140,
              child: ElevatedButton(
                  onPressed: () {
                    validateForm();
                  },
                  child: Text(
                    " Registration",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: Color(000047),
                          )),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
