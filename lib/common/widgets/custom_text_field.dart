import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
   CustomTextField({Key? key, required this.controller, required this.hintText, this.maxLines =1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller ,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38
          )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black38
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: GlobalVariables.secondaryColor
            )
        ),
        

      ),
      validator: (val){
        if(val == null || val.isEmpty){
          return "Enter your $hintText";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
