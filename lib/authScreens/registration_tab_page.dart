import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/home_screen.dart';
import 'package:user_app/splachScreen/my_splash_screen.dart';
import 'package:user_app/widgets/custom_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/widgets/loading_dialog.dart';

class RegistrationTabPage extends StatefulWidget {
  const RegistrationTabPage({Key? key}) : super(key: key);

  @override
  State<RegistrationTabPage> createState() => _RegistrationTabPageState();
}

class _RegistrationTabPageState extends State<RegistrationTabPage> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = "";

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGellery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  fromValidation() async {
    if (imgXFile == null) // if image is not selected
    {
      Fluttertoast.showToast(msg: "Please select an image");
    } else // if image is already selected
    {
      // pasword is equal to confirm password
      if (passwordEditingController.text.trim() ==
          confirmPasswordEditingController.text.trim()) {
        // check email , paas , confirm pass , and text field
        if (emailEditingController.text.isNotEmpty &&
            nameEditingController.text.isNotEmpty &&
            passwordEditingController.text.isNotEmpty &&
            confirmPasswordEditingController.text.isNotEmpty) {

              showDialog(
                context: context,
                 builder: (c){
                  return LoadungDailog(
                message: "Registering your account",
              );
                 }
                 );
          // 1 upload image to storage

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
              .ref()
              .child("usersImages")
              .child(fileName);

          fStorage.UploadTask uploadImageTask =
              storageRef.putFile(File(imgXFile!.path));

          fStorage.TaskSnapshot taskSnapshot =
              await uploadImageTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((urlImage) {
            downloadUrlImage = urlImage;
          });

          //2 save the user info to the firebase database
          saveInformationToDatabase();
        } else {
           Navigator.pop(context);
          Fluttertoast.showToast(
              msg:"Please complete the form , Do not leave  any text field empty");
        }
      } else //pasword is  not equal to confirm password
      {
        Fluttertoast.showToast(msg: "Enter the correct password");
      }
    }
  }




  // saveInformationToDatabase() async{

  //   // authenticate the user 
  //   User? currentUser;

  //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: emailEditingController.text.trim(), 
  //     password: passwordEditingController.text.trim())
  //     .then((auth) {
  //      currentUser = auth.user;
  //     }).catchError((errorMessage){
  // Fluttertoast.showToast(msg: "Eroor Ocuured: /n $errorMessage");
  //     });

  // }

  saveInformationToDatabase() async {
    // Authonticate the user
    
   User ? currentUser;

   await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailEditingController.text.trim(),
            password: passwordEditingController.text.trim(),)
        .then((auth) {
          currentUser= auth.user;
        }).catchError((errorMessage) {
          Navigator.pop(context);

          Fluttertoast.showToast(msg: "Error Ocurred: /n $errorMessage");

        });

        if(currentUser!= null){
          // save info to database and save locally using shared Preferences

          saveInfoFirestoreAndLocally(currentUser!);
        }
    
   }

  saveInfoFirestoreAndLocally(User currentUser) async{

    // save firestore 

    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid":currentUser.uid,
      "email":currentUser.email,
      "name":nameEditingController.text.trim(),
      "photoUrl":downloadUrlImage,
      "status":"approved",
      "userCart":["initialValue"],
    });

    // save locally

    sharedPreferences =  await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid",currentUser.uid);
    await sharedPreferences!.setString("email",currentUser.email!);
    await sharedPreferences!.setString("name",nameEditingController.text.trim());
    await sharedPreferences!.setString("photoUrl",downloadUrlImage);
    // sharedPreferences!.setString("status","approved");
    await sharedPreferences!.setStringList("userCart",["initialValue"]);

    Navigator.push(context, MaterialPageRoute(builder: (context) =>MySplashScreen() ));

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          // get capture image
          GestureDetector(
            onTap: () {
              getImageFromGellery();
            },
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 1, 23, 60),
              radius: MediaQuery.of(context).size.width * 0.1,
              backgroundImage: imgXFile == null
                  ? null
                  : FileImage(
                      File(imgXFile!.path),
                    ),
              child: imgXFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.1,
                    )
                  : null,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Form(
            key: formKey,
            child: Column(
              children: [
                // input form field

                // name

                CustomTextField(
                  textEditingController: nameEditingController,
                  hintText: "Enter the Name ",
                  isObscure: false,
                  enabled: true,
                  iconData: Icons.person,
                ),

                CustomTextField(
                  textEditingController: emailEditingController,
                  hintText: " Email ",
                  isObscure: false,
                  enabled: true,
                  iconData: Icons.email,
                ),

                CustomTextField(
                    textEditingController: passwordEditingController,
                    hintText: "Password ",
                    isObscure: true,
                    enabled: true,
                    iconData: Icons.lock),

                CustomTextField(
                  textEditingController: confirmPasswordEditingController,
                  hintText: "Confirm Password ",
                  isObscure: true,
                  enabled: true,
                  iconData: Icons.lock,
                ),

                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),

          SizedBox(
            height: 50,
            width: 140,
            child: ElevatedButton(
                onPressed: () {
                 fromValidation();

                },
                child: Text(
                  " Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.black,
                        )),
                  ),
                )),
          )
        ],
      )),
    );
  }
}
