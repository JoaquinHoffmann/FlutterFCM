import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextInputType inputType; //sirve para hacer 1 o varias líneas de texto
  final TextEditingController controller; //Para trabajar el fomulario
  final int maxLines;

  TextInput(
      {@required this.hintText,
      @required this.inputType,
      @required this.controller,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      child: TextField(
          controller: controller,
          keyboardType: inputType,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: "Lato",
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFd4d4d4),
              border: InputBorder.none,
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFd4d4d4)),
                  borderRadius: BorderRadius.all(Radius.circular(9.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFd4d4d4)),
                  borderRadius: BorderRadius.all(Radius.circular(9.0))))),
    );
  }
}
