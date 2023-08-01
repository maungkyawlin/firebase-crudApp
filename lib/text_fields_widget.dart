import 'package:flutter/material.dart';

class MyTextFields {
  getTextFields(BuildContext context, String? hintText, String? label,
      {TextInputType textInputType = TextInputType.name,required TextEditingController controller,FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          
          hintText: hintText,
          label: Text("$label"),
          border:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}
