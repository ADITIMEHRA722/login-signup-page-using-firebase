import 'package:flutter/material.dart';
class CustomTextField extends StatefulWidget {

  TextEditingController? textEditingController;
  IconData? iconData; 
  String? hintText;
  // String? label;
  bool? isObscure = true; 
  bool? enabled = true;
  CustomTextField({
    this.textEditingController,
    this.iconData,
    this.isObscure,
    this.hintText,
   this.enabled,
  //  this.label,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),

      child: TextFormField(

        enabled:  widget.enabled,
        controller: widget.textEditingController,
        obscureText: widget.isObscure!,

       cursorColor: Colors.blueGrey,

        decoration: InputDecoration(

          // border: InputBorder.none,
          border:OutlineInputBorder(
            borderSide: const BorderSide(color: Color(000047), width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          prefixIcon: Icon(widget.iconData),
          focusColor: Color(0x001a33),
          hintText: widget.hintText,
          //hintStyle: TextStyle(color: Color(000047), fontSize: 20)
         
        ),
        
      ),
    );
    
  }
}